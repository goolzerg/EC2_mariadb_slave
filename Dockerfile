FROM mariadb:10.2

RUN rm /etc/mysql/my.cnf

COPY /home/ubuntu/my.cnf /etc/mysql/