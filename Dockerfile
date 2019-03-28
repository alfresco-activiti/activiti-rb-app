FROM adoptopenjdk/openjdk11:jdk-11.0.2.7-alpine-slim
# Install the font required for runtime bundle BPMN diagram renderer. This will be removed later
#RUN sed -i -e 's/dl-cdn/dl-4/' /etc/apk/repositories && apk add --no-cache bash build-base
#RUN echo -e "http://nl.alpinelinux.org/alpine/v3.5/main\nhttp://nl.alpinelinux.org/alpine/v3.5/community" > /etc/apk/repositories
RUN echo http://mirror.yandex.ru/mirrors/alpine/v3.5/main > /etc/apk/repositories; echo http://mirror.yandex.ru/mirrors/alpine/v3.5/community >> /etc/apk/repositories
RUN apk update && apk add --no-cache 
RUN apk --update add fontconfig ttf-dejavu msttcorefonts-installer fontconfig && update-ms-fonts && fc-cache -f
ENV PORT 8080
EXPOSE 8080
COPY target/*.jar /opt/app.jar
WORKDIR /opt
ENTRYPOINT ["sh","-c", "java $JAVA_OPTS -jar app.jar"]

