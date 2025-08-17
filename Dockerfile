# Copyright © Michal Čihař <michal@weblate.org>
# SPDX-License-Identifier: GPL-3.0-or-later

FROM weblate/dev:2025.33.0@sha256:321806479666695fa895fe80c4ac994f442a6204e4ebbb459dc0e8847b49a1d0 AS build

COPY README.md LICENSE pyproject.toml /app/src/
COPY ./locale_lint/ /app/src/locale_lint

# hadolint ignore=SC1091
RUN \
    uv venv --python python3.13 /app/venv && \
    source /app/venv/bin/activate && \
    uv pip install --no-cache-dir -e /app/src

FROM weblate/base:2025.34.0@sha256:334653e9bf335a1bd2da230547fcee45b482c1452b88214d5d2317574a0731f6 AS final

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
