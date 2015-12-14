准备Cert

```
mkdir -p certs && openssl req \
  -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key \
  -x509 -days 365 -out certs/domain.crt 
```

启动Image

```
docker run -it -d --name reg -p 5000:5000 --restart=always -v /opt/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  -v /opt/reg:/var/lib/registry registry:2.2.1
```
