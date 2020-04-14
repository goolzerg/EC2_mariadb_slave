FROM mariadb:10.2

RUN rm /etc/mysql/my.cnf

COPY my.cnf /etc/mysql/