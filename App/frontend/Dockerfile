FROM nginx:latest
LABEL authors="Bruno Ramos"

COPY index.html /usr/share/nginx/html/index.html
COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
