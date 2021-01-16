FROM python:3.8-alpine

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-libs
RUN apk add --no-cache --virtual .tmp gcc libc-dev linux-headers musl-dev postgresql-dev
RUN pip install --upgrade pip
RUN pip --default-timeout=1000 install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /app
COPY . /app
WORKDIR /app
COPY ./entrypoint.sh /

ENTRYPOINT [ "sh","/entrypoint.sh" ]