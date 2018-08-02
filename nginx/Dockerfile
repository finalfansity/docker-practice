FROM centos
RUN yum install -y pcre-devel wget net-tools gcc zlib zlib-devel make openssl-devel
ADD http://nginx.org/download/nginx-1.15.0.tar.gz .
RUN tar zxvf nginx-1.15.0.tar.gz
RUN mkdir -p /usr/local/nginx
RUN cd nginx-1.15.0 && ./configure --prefix=/usr/local/nginx && make && make install
#RUN rm -fv /usr/local/nginx/conf/nginx.conf
#COPY .nginx_conf /usr/local/nginx/conf/nginx.conf
EXPOSE 80
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;", "-c", "/usr/local/nginx/conf/nginx.conf"]
