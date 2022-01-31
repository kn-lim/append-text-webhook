FROM debian:11-slim
WORKDIR /var/webhook
COPY run.sh run.sh
RUN chmod +x run.sh
COPY hooks.yml hooks.yml
COPY SECRET SECRET
RUN apt-get update && apt-get install webhook -y
EXPOSE 9000
CMD [ "webhook", "-hooks", "hooks.yml", "-verbose" ]