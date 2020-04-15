#!/bin/bash
PASSWORD=555
HOST_IP=$(hostname -i)
SLAVE_USER='rep_master'
CONTAINER_IP=$(sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' masha)
POS=$(mysql -u root --password=$PASSWORD -e "SHOW MASTER STATUS\G" | grep Position | sed 's/[^0-9]*//g')
FNAME=$(mysql -u root --password=$PASSWORD -e "SHOW MASTER STATUS\G" | grep File | sed 's/.*://' | sed 's/ //g')