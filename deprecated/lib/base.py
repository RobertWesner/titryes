# Copyright (C) 2024 Robert Wesner

import os


def build_docker_base():
    os.system('''
        docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) \\
            -t titryes/base \\
            docker >/dev/null 2>&1
    ''')


def build_xauth():
    os.system('xauth nlist $DISPLAY | sed -e "s/^..../ffff/" | xauth -f /tmp/.docker.xauth nmerge - > /dev/null 2>&1')

