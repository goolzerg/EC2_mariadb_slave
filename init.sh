#!/bin/bash
PASSWORD=555
HOST_IP=$(hostname -i)
SLAVE_USER='rep_master'

mysql -u root --password=$PASSWORD -e "CREATE USER '$SLAVE_USER'@'%' IDENTIFIED BY '$SLAVE_USER'; GRANT REPLICATION SLAVE ON *.* to '$SLAVE_USER'@'%'"

CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' masha)
POS=$(mysql -u root --password=$PASSWORD -e "SHOW MASTER STATUS\G" | grep Position | sed 's/[^0-9]*//g')
FNAME=$(mysql -u root --password=$PASSWORD -e "SHOW MASTER STATUS\G" | grep File | sed 's/.*://' | sed 's/ //g')
mysql -h $CONTAINER_IP -u root --password=$PASSWORD -e "stop slave; CHANGE MASTER TO MASTER_HOST='$HOST_IP', MASTER_USER='$SLAVE_USER', MASTER_PASSWORD='$SLAVE_USER',MASTER_LOG_FILE='$FNAME', MASTER_LOG_POS=$POS; start slave;"
