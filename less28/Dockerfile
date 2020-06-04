FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /usr/share/nginx/html
COPY otus.txt  /opt/
CMD ["nginx","-g","daemon off;"]
