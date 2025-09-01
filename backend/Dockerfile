# Stage 1: Maven 빌드
FROM maven:3.8.5-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: 실행용 이미지
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar ./app.jar
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]
