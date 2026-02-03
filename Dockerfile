FROM python:3.12-slim

WORKDIR /claude-code-proxy

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy package specifications
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --locked --no-install-project

# Copy project code
COPY . .

# Install the project itself
RUN uv sync --locked

# Start the proxy
EXPOSE 8082
CMD ["uv", "run", "uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8082"]
