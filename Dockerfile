# Stage 1: Build frontend
FROM node:14 as frontend-build
WORKDIR /app
COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install
COPY frontend .
ARG VUE_APP_API_URL
ENV VUE_APP_API_URL=${VUE_APP_API_URL}
RUN yarn build

# Stage 2: Setup backend and production stage
FROM python:3.8-slim
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y nginx curl

# Install Python dependencies
COPY backend/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy frontend build
COPY --from=frontend-build /app/dist /usr/share/nginx/html

# Copy backend
COPY backend .

# Copy the start script and Procfile
COPY start.sh /app/start.sh
COPY Procfile /app/Procfile

# Set correct permissions
RUN chmod +x /app/start.sh

# Expose ports
EXPOSE 80 5000

# Use the start script as the command
CMD ["/bin/bash", "/app/start.sh"]