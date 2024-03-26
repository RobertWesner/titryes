# Copyright (C) 2024 Robert Wesner

import os
from src import base

firefox_docker_built = False


def run(firefox_users):
    global firefox_docker_built

    print('\nAvailable users:')
    while True:
        for i, firefox_user in enumerate(firefox_users):
            print(f'[{i}] {firefox_user}')

        selection = input('> ')
        if selection.isdigit() and int(selection) < len(firefox_users):
            selected_user = firefox_users[int(selection)]
            break

    if not firefox_docker_built:
        print('Building docker container')
        os.system('docker build --build-arg user=$USER -t titryes/firefox docker/firefox > /dev/null 2>&1')
        firefox_docker_built = True

    base.run_browser('Firefox', 'titryes/firefox', selected_user)
