FROM maven:3.8.6-openjdk-11-slim AS build
COPY /src /usr/server-run/src
COPY /pom.xml /usr/server-run/
COPY /checkstyle.xml /usr/server-run/
WORKDIR /usr/server-run/
RUN mvn -f /usr/server-run/pom.xml verify -Djedismock.version=1.0.13

FROM openjdk:11-jdk-slim-sid
COPY --from=build /usr/server-run/target/*-with-dependencies.jar server.jar
EXPOSE 39807
ENTRYPOINT ["java", "-jar", "server.jar"]
