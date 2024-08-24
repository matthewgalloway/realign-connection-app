# Stage 1: Build frontend
FROM node:14 as frontend-build
WORKDIR /app
COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install
COPY frontend .
ARG VUE_APP_API_URL
ENV VUE_APP_API_URL=${VUE_APP_API_URL}
RUN yarn build

# Stage 2: Setup backend
FROM python:3.8-slim as backend-build
WORKDIR /app
COPY backend/requirements.txt .
RUN pip install -r requirements.txt
COPY backend .

# Stage 3: Production stage
FROM python:3.8-slim
WORKDIR /app

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy frontend build
COPY --from=frontend-build /app/dist /usr/share/nginx/html

# Create a virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy backend and install requirements
COPY --from=backend-build /app /app/backend
RUN pip install -r /app/backend/requirements.txt

# Copy the start script and Procfile
COPY start.sh /app/start.sh
COPY Procfile /app/Procfile

# Set correct permissions and ownership
RUN chown -R www-data:www-data /app
RUN chmod +x /app/start.sh

# Expose ports
EXPOSE 80 5000

# Switch to www-data user
USER www-data

# Use the start script as the command
CMD ["/bin/bash", "/app/start.sh"]  