FROM python:3.11-slim

# Install additional system packages
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install uv

RUN mkdir -p /data/python-sandbox/