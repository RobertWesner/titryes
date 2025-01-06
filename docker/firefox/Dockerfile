# Copyright (C) 2024 Robert Wesner

FROM titryes/base

RUN apk add firefox

ARG user
ENV USERNAME=${user}
USER ${user}

CMD ["firefox", "-P", "-allow-downgrade"]
