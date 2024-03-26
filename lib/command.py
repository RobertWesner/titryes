# Copyright (C) 2024 Robert Wesner

import os
import psutil
import sys

from lib import base
from browsers import firefox

firefox_users = []


def copy_ntfs_profiles(profile_dir):
    global firefox_users

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

            firefox_users = firefox.copy_windows_user(partition, user, profile_dir, firefox_users)

            if os.path.isdir(
                    os.path.join(partition.mountpoint, 'Users', user, 'AppData/Local/Microsoft/Edge/User Data')):
                pass
                # TODO: check if actually contains data
                # print('            - Edge')


def setup():
    # build base image for later use in all specific browser instances
    print('Building base docker container')
    base.build_docker_base()
    print('Creating xauth')
    base.build_xauth()

    # TODO: use a different directory
    profile_dir = os.path.realpath('./tmp')
    copy_ntfs_profiles(profile_dir)


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
