FROM node:18-alpine

# Create a non-root user and group
RUN addgroup app && adduser -S -G app app

WORKDIR /app

# Copy package files first for caching benefits
COPY package.json package-lock.json ./

# Install dependencies as root
RUN npm install

# Copy the rest of the application files
COPY . .

# Change ownership of all files (including node_modules) after copying
RUN chown -R app:app /app

# Switch to the non-root user
USER app

ENV API_URL=http://myapi.com/
EXPOSE 5173

CMD ["npm", "run", "dev"]

