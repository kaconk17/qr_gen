FROM python:3.8-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-libs
RUN apk add --no-cache --virtual .tmp gcc libc-dev linux-headers musl-dev postgresql-dev
RUN pip install --upgrade pip
RUN pip --default-timeout=1000 install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /app
COPY . /app
WORKDIR /app
COPY ./scripts /scripts

RUN chmod +x /scripts/*

RUN mkdir -p /media
RUN mkdir -p /staticfiles

RUN adduser -D user
RUN chown -R user:user /staticfiles
RUN chmod -R 755 /staticfiles
RUN chown -R user:user /media
RUN chmod -R 755 /media
USER user

CMD ["entrypoint.sh"]