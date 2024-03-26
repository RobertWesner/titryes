# Copyright (C) 2024 Robert Wesner

import os


def run_browser(name, container, user):
    print(f'Starting {name}')
    os.system(f'''
        docker run -e DISPLAY=$DISPLAY \\
            -v /tmp/.X11-unix:/tmp/.X11-unix \\
            -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \\
            -v ./tmp/{user}:/home/$USER \\
            -e XAUTHORITY=/tmp/.docker.xauth \\
            -t {container} > /dev/null 2>&1 
    ''')