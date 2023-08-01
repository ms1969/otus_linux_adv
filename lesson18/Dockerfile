FROM alpine:latest

RUN apk update && apk upgrade && apk add nginx && apk add bash



EXPOSE 80

COPY nginx_cfg/default.conf /etc/nginx/http.d/
COPY nginx_cfg/index.html /var/www/default/html/


CMD ["nginx", "-g", "daemon off;"]


