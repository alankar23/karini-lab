FROM python:3.12-alpine

WORKDIR /app

EXPOSE 8000

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY main.py .

ENTRYPOINT [ "python" ]

CMD [ "main.py" ]