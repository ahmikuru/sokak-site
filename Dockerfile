FROM node:20-slim

# Install unzip
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copy zipped project
COPY sokak-site.zip ./

# Unzip the project
RUN unzip sokak-site.zip -d . && rm sokak-site.zip && \
    mv sokak-site/* . && rm -rf sokak-site

# Install dependencies without dev dependencies
RUN npm install --omit=dev

# Set environment variables
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000

EXPOSE 3000

# Start the server
CMD ["node", "src/server.js"]
