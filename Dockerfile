# Build stage (Maven with a JDK 21 distribution)
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

# copy pom first so dependencies are cached when source changes
COPY pom.xml .
RUN mvn -B -DskipTests dependency:go-offline

# copy sources and build
COPY src ./src
RUN mvn -B -DskipTests package

# Package stage (runtime with Temurin JDK 21)
FROM eclipse-temurin:21-jdk
WORKDIR /app

# copy the built jar (use wildcard to avoid hard-coded artifact name)
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
