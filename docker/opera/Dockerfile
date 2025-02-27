# Copyright (C) 2024 Robert Wesner

FROM titryes/base-ubuntu


RUN curl -fsSL https://deb.opera.com/archive.key | gpg --dearmor | tee /usr/share/keyrings/opera.gpg > /dev/null
RUN echo deb [arch=amd64 signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free | tee /etc/apt/sources.list.d/opera.list
RUN apt-get update && apt-get -y install opera-stable

ARG user
ENV USERNAME=${user}
USER ${user}

CMD ["opera", "--no-sandbox"]
