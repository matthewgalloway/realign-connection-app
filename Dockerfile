FROM alpine:latest

# Install bash
RUN apk add --no-cache bash

# Copy the start script and Procfile
COPY start.sh /app/start.sh
COPY Procfile /app/Procfile

# Set correct permissions
RUN chmod +x /app/start.sh

# Set working directory
WORKDIR /app

# Use the Procfile command
CMD ["sh", "-c", "$(cat Procfile | cut -d' ' -f2-)"]