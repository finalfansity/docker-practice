FROM centos:latest
 
#安装相关依赖
RUN yum -y install  gcc gcc-c++ autoconf automake make
RUN yum -y install  zlib zlib-devel openssl* pcre* wget lua-devel
 
#MAINTAINER 维护者信息
MAINTAINER zhuhui douma515253@gmail.com
 
#ADD  获取url中的文件,放在当前目录下
ADD http://nginx.org/download/nginx-1.16.0.tar.gz /tmp/
#LuaJIT 2.1
#ADD http://luajit.org/download/LuaJIT-2.0.5.tar.gz /tmp/
ADD https://github.com/LuaJIT/LuaJIT/archive/v2.0.5.tar.gz /tmp/
#ngx_devel_kit（NDK）模块
ADD https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz /tmp/
#lua-nginx-module 模块
ADD https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz /tmp/
#nginx ngx_cache_purge模块
ADD http://labs.frickle.com/files/ngx_cache_purge-2.3.tar.gz  /tmp/
 
 
#切换目录
WORKDIR  /tmp 
 
#安装LuaJIT 2.0.5
#RUN wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz -P /tmp/
RUN tar zxf v2.0.5.tar.gz
WORKDIR  /tmp/LuaJIT-2.0.5
#RUN cd LuaJIT-2.0.5
RUN make PREFIX=/usr/local/luajit 
RUN make install PREFIX=/usr/local/luajit
 
#安装ngx_devel_kit(NDK)
WORKDIR  /tmp
RUN tar -xzvf v0.3.0.tar.gz
RUN cp -r ngx_devel_kit-0.3.0/ /usr/local/src/
 
#安装lua-nginx-module模块
RUN tar -xzvf v0.10.13.tar.gz
RUN cp -r lua-nginx-module-0.10.13/ /usr/local/src/
 
#安装nginx ngx_cache_purge模块
RUN tar -xzvf ngx_cache_purge-2.3.tar.gz
RUN cp -r ngx_cache_purge-2.3/ /usr/local/src/
 
#设置环境变量
RUN export LUAJIT_LIB=/usr/local/lib
RUN export LUAJIT_INC=/usr/local/include/luajit-2.0
 
RUN mkdir -p {/usr/local/nginx/logs,/var/lock}
 
#编译安装Nginx
RUN useradd -M -s /sbin/nologin nginx
RUN tar -zxvf nginx-1.16.0.tar.gz
RUN mkdir -p /usr/local/nginx
RUN cd /tmp/nginx-1.16.0 \
	&& ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx \
	--error-log-path=/usr/local/nginx/logs/error.log \
	--http-log-path=/usr/local/nginx/logs/access.log \
	--pid-path=/usr/local/nginx/logs/nginx.pid \
	--lock-path=/var/lock/nginx.lock \
	--with-ld-opt="-Wl,-rpath,/usr/local/luajit/lib" \
	--with-http_stub_status_module \
	--with-http_ssl_module \
	--with-http_sub_module \
	--add-module=/usr/local/src/lua-nginx-module-0.10.13 \
	--add-module=/usr/local/src/ngx_devel_kit-0.3.0 \
	--add-module=/usr/local/src/ngx_cache_purge-2.3 \
	&& make && make install
#参数说明
#--prefix 用于指定nginx编译后的安装目录
#--add-module 为添加的第三方模块，此次添加了fdfs的nginx模块
#--with..._module 表示启用的nginx模块，如此处启用了http_ssl_module模块	
 
RUN /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
RUN ln -s /usr/local/nginx/sbin/* /usr/local/sbin/

RUN yum clean all && rm -rf /tmp/* 
#EXPOSE 映射端口
EXPOSE 80 443
 
#CMD 运行以下命令
#CMD ["nginx"]
CMD ["/usr/local/nginx/sbin/nginx","-g","daemon off;"]
