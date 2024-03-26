FROM alpine:3.19 AS base

# TODO: is xf86-input-libinput necessary?
RUN apk add xorg-server xf86-input-libinput

RUN apk add font-terminus font-noto font-noto-extra font-arabic-misc
RUN apk add font-misc-cyrillic font-mutt-misc font-screen-cyrillic font-winitzki-cyrillic font-cronyx-cyrillic
RUN apk add font-noto-arabic font-noto-armenian font-noto-cherokee font-noto-devanagari font-noto-ethiopic font-noto-georgian
RUN apk add font-noto-hebrew font-noto-lao font-noto-malayalam font-noto-tamil font-noto-thaana font-noto-thai

ARG user
ARG uid
ARG gid

RUN addgroup --gid ${gid} $USERNAME \
    && adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/$USERNAME" \
    --ingroup "$USERNAME" \
    --no-create-home \
    --uid ${uid} \
    $USERNAME

WORKDIR /home/${user}
