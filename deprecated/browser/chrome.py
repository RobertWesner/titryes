# Copyright (C) 2024 Robert Wesner

import os
import shutil

from lib import browser_base

chrome_docker_built = False


def copy_windows_user(partition, user, profile_dir, user_list):
    if os.path.isdir(os.path.join(partition.mountpoint, 'Users', user, 'AppData/Local/Google/Chrome')):
        print('            - Chrome ', end='')
        # TODO: test if this includes extensions
        src = os.path.join(partition.mountpoint, 'Users', user, 'AppData/Local/Google/Chrome/User Data')
        dest = os.path.join(profile_dir, user, '.google-chrome/chromium')
        shutil.copytree(src, dest, dirs_exist_ok=True)
        print('(copied)')
        user_list.append(user)

    return user_list

def run(user_list):
    global chrome_docker_built

    selected_user = browser_base.prompt_user(user_list)

    if not chrome_docker_built:
        print('Building docker container')
        os.system('docker build --build-arg user=$USER -t titryes/chrome docker/chrome # > /dev/null 2>&1')
        chrome_docker_built = True

    browser_base.run('Chrome', 'titryes/chrome', selected_user)
