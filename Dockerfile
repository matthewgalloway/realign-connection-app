# Stage 1: Build frontend
FROM node:14 as frontend-build
WORKDIR /workspace/frontend
COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install
COPY frontend ./
ARG VUE_APP_API_URL
ENV VUE_APP_API_URL=${VUE_APP_API_URL}
RUN yarn build

# Stage 2: Setup backend and production stage
FROM ubuntu:20.04
WORKDIR /workspace

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PATH="/usr/local/bin:${PATH}"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    nginx \
    curl

# Upgrade pip
RUN python3 -m pip install --no-cache-dir --upgrade pip

# Install Python dependencies
COPY backend/requirements.txt /workspace/backend/
RUN python3 -m pip install --no-cache-dir -r /workspace/backend/requirements.txt

# Copy frontend build
COPY --from=frontend-build /workspace/frontend/dist /workspace/frontend/dist

# Copy backend
COPY backend /workspace/backend

# Copy the start script and Procfile
COPY start.sh /workspace/start.sh
COPY Procfile /workspace/Procfile

# Copy other necessary files
COPY package.json yarn.lock /workspace/

# Set correct permissions
RUN chmod +x /workspace/start.sh

# Expose ports
EXPOSE 80 5000

# Set Python path
ENV PYTHONPATH=/workspace/backend

# Use the start script as the command
CMD ["/bin/bash", "/workspace/start.sh"]
