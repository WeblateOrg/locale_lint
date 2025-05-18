# Copyright © Michal Čihař <michal@weblate.org>
# SPDX-License-Identifier: GPL-3.0-or-later

FROM weblate/dev:2025.21.0@sha256:3e3382a2dbb15b481800640238c0d42ccb6a2bc13d2608883510701a6e0dae59 AS build

COPY README.md LICENSE pyproject.toml /app/src/
COPY ./locale_lint/ /app/src/locale_lint

# hadolint ignore=SC1091
RUN \
    uv venv --python python3.13 /app/venv && \
    source /app/venv/bin/activate && \
    uv pip install --no-cache-dir -e /app/src

FROM weblate/base:2025.21.0@sha256:658528b164d7b76b497f4da442573a21bc9924199368c571293b8c312dfc2cb6 AS final

LABEL name="locale_lint"
LABEL maintainer="Michal Čihař <michal@cihar.com>"
LABEL org.opencontainers.image.url="https://weblate.org/"
LABEL org.opencontainers.image.documentation="https://docs.weblate.org/"
LABEL org.opencontainers.image.source="https://github.com/WeblateOrg/locale_lint"
LABEL org.opencontainers.image.author="Michal Čihař <michal@weblate.org>"
LABEL org.opencontainers.image.vendor="Weblate"
LABEL org.opencontainers.image.title="locale_lint"
LABEL org.opencontainers.image.description="Weblate Locale Linter"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

# Copy built environment
COPY --from=build /app /app

WORKDIR /home/weblate
USER weblate

ENTRYPOINT ["/app/venv/bin/locale_lint"]
