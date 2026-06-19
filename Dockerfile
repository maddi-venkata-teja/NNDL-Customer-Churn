FROM python:3.11-slim

WORKDIR /app

# Install system dependencies if required, slim down image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Cloud Run injects the PORT environment variable dynamically
CMD gunicorn --bind 0.0.0.0:$PORT app:app
