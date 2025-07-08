INIT_DB=mariainitdb
USERNAME_DB=jim
PASSWORD_DB=admin123
docker run -d \
    --name mariadb-container \
    -e MYSQL_ROOT_PASSWORD=root123 \
    -e MYSQL_DATABASE=$INIT_DB \
    -e MYSQL_USER=$USERNAME_DB \
    -e MYSQL_PASSWORD=$PASSWORD_DB \
    -p 3306:3306 \
    mariadb:latest