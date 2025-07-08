docker run -d --name retodia10-docker ubuntu bash -c '
mensajes=(
    "Tu contenedor está listo para deploy"
    "Pipeline verde, desarrollador feliz" 
    "Docker build exitoso, día productivo"
    "CI/CD funcionando, todo bajo control"
    "Container running smooth como tu código"
    "Microservicios desplegados, misión cumplida"
    "Logs claros, debugging rápido"
    "Health check passed, servicio healthy"
)
while true; do 
    indice=$((RANDOM % ${#mensajes[@]}))
    echo "$(date +"%T") - ${mensajes[$indice]}" >> mensajes.txt
    sleep 5
done'


docker run --rm -e INIT_DB=mariainitdb -e PASSWORD_DB=admin123 -e USERNAME_DB=jim \
    --name mariadb-container \
    -e MYSQL_ROOT_PASSWORD=root123 \
    -e MYSQL_DATABASE=$INIT_DB \
    -e MYSQL_USER=$USERNAME_DB \
    -e MYSQL_PASSWORD=$PASSWORD_DB \
    -p 3306:3306 \
  mariadb:latest