FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y nginx
COPY index.html /var/www/html/index.html

#FROM nginx:stable-alpine
#COPY index.html /usr/share/nginx/html/index.html
