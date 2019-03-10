FROM postgres:10.7

ENV POSTGRES_USER postgres  
ENV POSTGRES_PASSWORD postgres  
ENV POSTGRES_DB postgres  

RUN apt-get update && apt-get install -y \
    telnet 

COPY ./docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/
