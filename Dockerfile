FROM python:3.12-slim

ARG TARGETARCH
COPY app /app
WORKDIR /app
CMD ["python", "-m", "app"]
