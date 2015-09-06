RUN:
docker run -d -v /tmp:/tmp/dshare --name psqldb -e POSTGRES_PASSWORD=postgres postgres
