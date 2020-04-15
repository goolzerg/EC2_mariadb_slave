FROM mariadb:10.2

RUN rm /etc/mysql/my.cnf && \
chmod 644 /etc/mysql/my.cnf

ADD https://raw.githubusercontent.com/goolzerg/mariadb_ainstall/master/my.cnf /etc/mysql/