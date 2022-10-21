FROM python:3.9.15-slim-bullseye

COPY bootstrap /
COPY bootstrap/profiles.yml /root/.dbt/profiles.yml

RUN pip install -r requirements.txt
