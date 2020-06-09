FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
CMD mkdir -p /etc/nginx/html
COPY otus.txt /opt/
CMD ["nginx","-g","daemon off;"]
