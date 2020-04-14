FROM mariadb:10.2

RUN rm /etc/mysql/my.cnf

COPY https://raw.githubusercontent.com/goolzerg/mariadb_ainstall/master/my.cnf /etc/mysql/