RUN:
docker run -d -v /tmp:/tmp/dshare -v /tmp/pgdata:/psqldata -e PGDATA=/psqldata --name psqldb -e POSTGRES_PASSWORD=postgres postgres 

docker run -d -v /tmp:/tmp/dshare -v /tmp/pgdata:/psqldata -e PGDATA=/psqldata --name psqldb -e POSTGRES_PASSWORD=postgres postgres  
