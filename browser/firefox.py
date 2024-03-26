# Copyright (C) 2024 Robert Wesner

import os
import shutil

from lib import browser_base

firefox_docker_built = False


def copy_windows_user(partition, user, profile_dir, user_list):
    if os.path.isdir(os.path.join(partition.mountpoint, 'Users', user, 'AppData/Roaming/Mozilla/Firefox')):
        print('            - Firefox ', end='')
        src = os.path.join(partition.mountpoint, 'Users', user, 'AppData/Roaming/Mozilla/Extensions')
        dest = os.path.join(profile_dir, user, '.mozilla/extensions')
        shutil.copytree(src, dest, dirs_exist_ok=True)
        src = os.path.join(partition.mountpoint, 'Users', user, 'AppData/Roaming/Mozilla/Firefox')
        dest = os.path.join(profile_dir, user, '.mozilla/firefox')
        shutil.copytree(src, dest, dirs_exist_ok=True)
        print('(copied)')
        user_list.append(user)

    return user_list


def run(user_list):
    global firefox_docker_built

    selected_user = browser_base.prompt_user(user_list)

    if not firefox_docker_built:
        print('Building docker container')
        os.system('docker build --build-arg user=$USER -t titryes/firefox docker/firefox > /dev/null 2>&1')
        firefox_docker_built = True

    browser_base.run('Firefox', 'titryes/firefox', selected_user)
