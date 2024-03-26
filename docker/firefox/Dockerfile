FROM titryes/base

RUN apk add firefox

ARG user
ENV USERNAME ${user}
USER ${user}

CMD ["firefox", "-P"]