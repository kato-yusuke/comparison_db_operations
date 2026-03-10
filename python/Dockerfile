FROM python:3.14-alpine

ENV PYTHONUNBUFFERED=1

RUN mkdir -p /usr/src/app
COPY requirements.txt /usr/src/app/
WORKDIR /usr/src/app

RUN apk add --no-cache \
    gcc \
    python3-dev \
    libc-dev \
    mariadb-dev

RUN pip install --upgrade pip\
    && pip install --upgrade setuptools\
    && pip install -r requirements.txt

CMD ["python","db_test/manage.py","runserver","0.0.0.0:8000"]
