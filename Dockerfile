# Stage 1: Build with full JDK and Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /workspace

# Copy dependency descriptors first to leverage Docker layer cache
COPY pom.xml ./
COPY .mvn .mvn

# Download dependencies (offline) to cache them
RUN mvn -B -ntp dependency:go-offline

# Copy source and build the application
COPY src ./src
RUN mvn -B -ntp package -DskipTests

# Stage 2: Production image (distroless, non-root)
FROM gcr.io/distroless/java17-debian11:nonroot

# Use the artifact produced in the build stage
ARG JAR_FILE=/workspace/target/*.jar
COPY --from=builder ${JAR_FILE} /app/app.jar

# Ensure running as non-privileged user (distroless nonroot uid)
USER 65532:65532

# Application listens on 8080 by default
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","/app/app.jar"]
