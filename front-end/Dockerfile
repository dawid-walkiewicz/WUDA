FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install gunicorn

COPY . /app

EXPOSE 5000

CMD gunicorn --bind 0.0.0.0:${APP_PORT:-8000} app:app