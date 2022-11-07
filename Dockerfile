 FROM centos:latest

    COPY CentOS-Linux-AppStream.repo /etc/yum.repos.d/
    COPY CentOS-Linux-BaseOS.repo /etc/yum.repos.d/

    RUN mkdir /run/php-fpm
    RUN yum install httpd -y
    RUN yum install php php-mysqlnd php-mbstring php-xml php-opcache php-fpm  -y
    RUN command mkdir -p /var/run/


    COPY index.php /var/www/html/
    COPY index.html /var/www/html/
    COPY script.sh /app/script.sh
    
    
    EXPOSE  80
    RUN chmod 755 /app/script.sh

    CMD "/app/script.sh"

