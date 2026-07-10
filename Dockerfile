FROM docker:25.0-dind
LABEL org.opencontainers.image.source="https://github.com/locomotive-agency/mcp-anywhere"
RUN apk update && apk upgrade --no-interactive && apk add tini sqlite
RUN apk add --no-cache python3 git fuse-overlayfs tini nodejs-current npm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
WORKDIR /app
COPY . /app/
RUN uv sync --locked --no-dev

ENV PATH="/app/.venv/bin:$PATH"
EXPOSE 8000

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["tini", "-s", "--", "python", "-m", "mcp_anywhere", "serve", "http"]