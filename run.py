# Copyright (C) 2024 Robert Wesner

import psutil
import os
import shutil
import sys

from src import firefox

# build base image
print('Building base docker container')
os.system('''
    docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) \\
        -t titryes/base \\
        docker >/dev/null 2>&1
''')
print('Creating xauth')
os.system('xauth nlist $DISPLAY | sed -e "s/^..../ffff/" | xauth -f /tmp/.docker.xauth nmerge - > /dev/null 2>&1')

# TODO: use a different directory
profile_dir = os.path.realpath('./tmp')
print(profile_dir)

firefox_users = []

partitions = [partition for partition in psutil.disk_partitions() if partition.fstype.startswith('ntfs')]
if len(partitions) == 0:
    print('No mounted NTFS partitions detected.')

for partition in partitions:
    print(f'Detected NTFS ({partition.fstype}) partition on device {partition.device}')

    is_windows_partition = True
    for directory in ['Windows', 'Users']:
        path = os.path.join(partition.mountpoint, directory)
        if not os.path.isdir(path):
            is_windows_partition = False
            break

    if not is_windows_partition:
        print('    Not a windows system partition')
        continue

    print('    Windows system partition detected')

    users = []
    for directory in next(os.walk(os.path.join(partition.mountpoint, 'Users')))[1]:
        if not os.path.isdir(os.path.join(partition.mountpoint, 'Users', directory)):
            continue

        if directory in ['Default', 'Default User']:
            continue

        users.append(directory)

    if len(users) == 0:
        print('    No users found')
        continue

    print(f'    Found {len(users)} users:')
    for user in users:
        print(f'        - {user}')

        if os.path.isdir(os.path.join(partition.mountpoint, 'Users', user, 'AppData/Roaming/Mozilla/Firefox')):
            print('            - Firefox ', end='')
            src = os.path.join(partition.mountpoint, 'Users', user, 'AppData/Roaming/Mozilla/Extensions')
            dest = os.path.join(profile_dir, user, '.mozilla/extensions')
            shutil.copytree(src, dest, dirs_exist_ok=True)
            src = os.path.join(partition.mountpoint, 'Users', user, 'AppData/Roaming/Mozilla/Firefox')
            dest = os.path.join(profile_dir, user, '.mozilla/firefox')
            shutil.copytree(src, dest, dirs_exist_ok=True)
            print('(copied)')
            firefox_users.append(user)

        if os.path.isdir(os.path.join(partition.mountpoint, 'Users', user, 'AppData/Local/Microsoft/Edge/User Data')):
            pass
            # TODO: check if actually contains data
            # print('            - Edge')


def run():
    global firefox_users

    print('\nAvailable browsers:')
    print(f'   [0] Firefox: {len(firefox_users)}')
    print(f'   [e] exit')
    while True:
        match input('> '):
            case '0':
                firefox.run(firefox_users)
                break
            case 'e':
                print('Goodbye')
                sys.exit(0)

    run()


run()
