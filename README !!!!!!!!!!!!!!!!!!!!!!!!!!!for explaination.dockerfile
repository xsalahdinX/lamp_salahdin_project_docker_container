

##at the first i decided to use centos as a base because i allways deal with it in my regular work
FROM centos:latest


## i have figured that the repo has been changed from the first of this year by adding "vault" so i replaced the repos first
    COPY CentOS-Linux-AppStream.repo /etc/yum.repos.d/
    COPY CentOS-Linux-BaseOS.repo /etc/yum.repos.d/


##this piece of run command cost me 3 hours searching to figure that it must be created for php to work 
    RUN mkdir /run/php-fpm

## regular commands of installing the lamp
    RUN yum install httpd -y
    RUN yum install mysql-server mysql  -y
    RUN yum install php php-mysqlnd php-mbstring php-xml php-opcache php-fpm  -y

##the pages to test the php and the html functionality 
    COPY index.php /var/www/html/
    COPY index.html /var/www/html/

##this is the real challenge ! how can i run 2 app by default when the container start the container run for 1 process pid1 and if it ended the container will exit 
##! furthermore if we succeeded play one process! , we need 2 process 1 httpd and 1 php run by default without any interaction with the user it can done easly by 2 commands
## /usr/sbin/hhtp , /usr/bin/php-fpm but AFTER 10 HOURS SEARCHING I REALIZED THAT I HAVE TO TYPE A SCRIPT FOR THIS ! not just regular command in CMD or ENTRYPOINt ;()  
    COPY script.sh /app/script.sh
    
##this port expose just for comment but the reall expose is by using docker run -p porthost : portcontainer i spend like hour searching but i didnt find any command in dockerfile 
    EXPOSE  80
##we have to give the script permission to run ! avpiding access denied
    RUN chmod 755 /app/script.sh

##finally this simple script take about 90% from my work and the rest take just % less than 2 hours :()
    CMD "/app/script.sh"