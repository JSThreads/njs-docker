# Njs (Nginx) Docker image
# Created by Jasiukiewicz Tymon
# Github: https://github.com/PovaJS/njs-docker

FROM ubuntu

# Updating container
RUN apt update

# Installing njs
RUN apt update
RUN apt install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring
RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN apt update
RUN apt install -y nginx-module-njs

# Adding the config line to Nginx config
RUN echo "$(echo -n 'load_module modules/ngx_http_js_module.so;\nload_module modules/ngx_stream_js_module.so;\n\n'; cat /etc/nginx/nginx.conf)" > /etc/nginx/nginx.conf
