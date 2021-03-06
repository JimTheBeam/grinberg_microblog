FROM python:3.8.5-alpine

RUN adduser -D microblog

WORKDIR /home/microblog


COPY requirements.txt requirements.txt
RUN python -m venv env
RUN env/bin/pip install -r requirements.txt
RUN env/bin/pip install gunicorn
RUN env/bin/pip install gunicorn pymysql

COPY app app
COPY migrations migrations
COPY microblog.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP microblog.py

RUN chown -R microblog:microblog ./
USER microblog

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]