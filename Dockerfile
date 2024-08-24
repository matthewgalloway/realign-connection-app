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
FROM python:3.10-slim
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y nginx curl

# Ensure pip is installed and updated
RUN apt-get install -y python3-pip && pip3 install --upgrade pip

# Install Python dependencies
COPY backend/requirements.txt /workspace/backend/
RUN pip3 install --no-cache-dir -r /workspace/backend/requirements.txt

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

# Use the start script as the command
CMD ["/bin/bash", "/workspace/start.sh"]