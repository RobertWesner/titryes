# Copyright (C) 2024 Robert Wesner

FROM titryes/base

# instead of building propriatary google chrome we just use chromium from the repository
RUN apk add chromium

ARG user
ENV USERNAME ${user}
ENV CHROME_CONFIG_HOME /home/${user}/.google-chrome
USER ${user}

# TODO: enable sandbox
CMD ["chromium", "--no-sandbox"]