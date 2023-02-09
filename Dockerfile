FROM python:3.11.2-slim-bullseye

LABEL name="locale_lint"
LABEL maintainer="Michal Čihař <michal@cihar.com>"
LABEL org.opencontainers.image.url="https://weblate.org/"
LABEL org.opencontainers.image.documentation="https://docs.weblate.org/"
LABEL org.opencontainers.image.source="https://github.com/WeblateOrg/locale_lint"
LABEL org.opencontainers.image.vendor="Michal Čihař"
LABEL org.opencontainers.image.title="locale_lint"
LABEL org.opencontainers.image.description="Weblate Locale Linter"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"

COPY README.md LICENSE setup.cfg setup.py requirements.txt /app/
COPY ./locale_lint/ /app/locale_lint

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN useradd --shell /bin/sh --user-group weblate --groups root,tty

# hadolint ignore=DL3008
RUN \
  export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install --no-install-recommends -y \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    gcc \
  && apt-get clean \
  && rm -rf /root/.cache /root/.cargo /tmp/* /var/lib/apt/lists/*

RUN pip install --no-cache-dir -e /app

WORKDIR /home/weblate
USER weblate

ENTRYPOINT ["locale_lint"]
