FROM maven:3.8.1-openjdk-8

#VOLUME /tmp
RUN mkdir /controltower
ADD controltower /controltower
WORKDIR /controltower

# Prepare by downloading dependencies
RUN ls -la
#RUN ["mvn", "dependency:resolve"]
#RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
RUN ["mvn", "clean", "install", "-DskipTests=true"]

#RUN ["ls", "/controltower/target"]
#RUN ["pwd"]
RUN ["ls", "-ltrh", "/controltower/target/ct-0.0.1-SNAPSHOT.jar"]

ADD ./entrypoint.sh /controltower
RUN chmod 755 /controltower/entrypoint.sh
EXPOSE 8080

#ENTRYPOINT [ "java", "-jar", "/controltower/target/ct-0.0.1-SNAPSHOT.jar" ]
CMD ["/bin/sh", "-c", "/controltower/entrypoint.sh"]
