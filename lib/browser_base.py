# Copyright (C) 2024 Robert Wesner

import os


def prompt_user(user_list):
    print('\nAvailable users:')
    while True:
        for i, user in enumerate(user_list):
            print(f'[{i}] {user}')

        selection = input('> ')
        if selection.isdigit() and int(selection) < len(user_list):
            return user_list[int(selection)]


def run(name, container, user):
    print(f'Starting {name}')
    os.system(f'''
        docker run -e DISPLAY=$DISPLAY \\
            -v /tmp/.X11-unix:/tmp/.X11-unix \\
            -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \\
            -v ./tmp/{user}:/home/$USER \\
            -e XAUTHORITY=/tmp/.docker.xauth \\
            -t {container} > /dev/null 2>&1 
    ''')