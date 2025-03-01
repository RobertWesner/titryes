## Copyright (C) 2024 Robert Wesner
#
#FROM titryes/base
#
#RUN apk add chromium
#
#ARG user
#ARG port
#ENV USERNAME=${user}
#ENV CHROME_CONFIG_HOME /home/${user}/.google-chrome
#
#RUN mkdir $CHROME_CONFIG_HOME && chown -R $USERNAME $CHROME_CONFIG_HOME
#
#USER ${user}
#
#CMD ["chromium", "--no-sandbox", "--app=http://localhost:48723"]
##CMD ["chromium", "--no-sandbox", "--app=http://google.com"]

# Copyright (C) 2024 Robert Wesner

FROM titryes/base

RUN apk add firefox

ARG user
ENV USERNAME=${user}

RUN mkdir -p /home/$USERNAME/.mozilla
RUN chown -R $USERNAME /home/$USERNAME
RUN #find /usr/share/applications/firefox.desktop -type f -exec sed -i 's/Icon=firefox/Icon=test/g' {} \;

COPY desktop.sh /home/$USERNAME/
RUN chmod +x /home/$USERNAME/desktop.sh

USER ${user}

ENTRYPOINT /home/dev/desktop.sh
