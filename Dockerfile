FROM python:3.13
LABEL maintainer="azunderstars"

ARG UID=1000 \
    GID=1000

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1   

WORKDIR /app
COPY requirements.txt /app
EXPOSE 8000 

RUN <<EOF
python -m venv /py
/py/bin/pip install --upgrade pip
/py/bin/pip install -r requirements.txt --no-cache-dir
groupadd -g ${GID} docker
useradd --no-create-home --no-log-init -u ${UID} -g ${GID} python
EOF

ENV PATH="/py/bin:$PATH"

USER python

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
