FROM python:3.13.0a2-slim

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--reload-dir", "app" ]
