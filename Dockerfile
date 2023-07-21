FROM python:3.8.13-slim-buster

# Install build dependencies (gcc and other necessary tools)
RUN apt-get update && \
    apt-get install -y gcc && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./my_app ./

RUN pip install --upgrade pip --no-cache-dir
RUN pip install -r /app/requirements.txt --no-cache-dir

# Use Gunicorn to run the application
# CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

CMD ["gunicorn", "main_app.wsgi:application", "--bind", "0.0.0.0:8000"]