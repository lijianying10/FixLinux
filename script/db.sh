docker run -dt --name cmysql -e MYSQL_ROOT_PASSWORD=1 -p 3306:3306 mysql:5.6
docker run -dt --name credis -p 6379:6379 redis
