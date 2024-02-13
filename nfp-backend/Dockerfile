FROM python:3.11-slim

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN apt-get update \
    && apt-get install -y libpq-dev gcc libffi-dev python3-dev build-essential \
    && pip install --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--reload-dir", "app" ]
