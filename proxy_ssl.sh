./proxy.sh

docker run -d \
    --name nginx-certs \
    --network=nginx-net \
    --restart unless-stopped \
    -v /etc/certs:/etc/nginx/certs:rw \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    --volumes-from nginx-proxy \
    jrcs/letsencrypt-nginx-proxy-companion