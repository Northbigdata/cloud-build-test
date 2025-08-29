# Dockerfile

# Stage 1: Build the Spring Boot application using Maven
FROM maven:3.8.5-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Build the final image with NGINX
FROM debian:bullseye-slim
WORKDIR /app

# Install NGINX
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copy NGINX configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy the built Spring Boot JAR file from the builder stage
COPY --from=builder /app/target/*.jar ./app.jar

# Expose ports
EXPOSE 8080 8081

# Command to start both NGINX and Spring Boot
CMD ["bash", "-c", "java -jar app.jar & nginx -g 'daemon off;'"]