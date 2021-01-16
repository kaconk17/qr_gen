FROM python:3.8-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install --upgrade pip
RUN pip --default-timeout=1000 install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /app
COPY . /app
WORKDIR /app
COPY ./scripts /scripts

RUN shmod +x /scripts/*

RUN mkdir -p /media
RUN mkdir -p /staticfiles

RUN adduser -D user
RUN chown -R user:user /staticfiles
RUN shmod -R 755 /staticfiles
RUN chown -R user:user /media
RUN shmod -R 755 /media
USER user

CMD ["entrypoint.sh"]