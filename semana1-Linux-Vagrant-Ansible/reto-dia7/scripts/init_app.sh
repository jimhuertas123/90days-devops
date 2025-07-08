#!/bin/bash
cd /vagrant

#necesary services for application
#turn on redis service (default port 6379)
until nc -z localhost 6379; do
  echo "Esperando a que Redis esté listo..."
  sleep 1
done
#turn on postgresql service (default port 5432)
until nc -z localhost 5432; do
  echo "Esperando a que PostgreSQL esté listo..."
  sleep 1
done

echo "127.0.0.1 database" | sudo tee -a /etc/hosts
echo "127.0.0.1 redis" | sudo tee -a /etc/hosts

#if roxs-devops-project90 directory exists, remove it
if [ -d "roxs-devops-project90" ]; then
    rm -rf roxs-devops-project90
fi

#clone repo of projects
git clone https://github.com/roxsross/roxs-devops-project90.git
if [ ! -d "roxs-devops-project90" ]; then
  echo "El clon del repositorio falló. Abortando."
  exit 1
fi
cd roxs-devops-project90/roxs-voting-app

#init roxs-voting-app:worker dependencies (node20.x)
cd worker 
npm install
npm run start > result.log 2>&1 &
echo "Worker service running"
cd ..

#init roxs-voting-app:vote dependencies (python 3.13+, redis 7.0.11)
cd vote 
pip install -r requirements.txt
gunicorn --bind 0.0.0.0:80 app:app &
echo "Vote service running"
cd ..

#init roxs-voting-app:result dependencies (node20.x)
cd result
npm install
WORKER_PORT=3001 npm run start > result.log 2>&1 &
echo "Result app running"
cd ..



