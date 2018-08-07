docker network create -d bridge nginx-net

docker run -d -p 80:80 -p 443:443 \
    --name nginx-proxy \
    -e ENABLE_IPV6=true \
    --restart unless-stopped \
    --network=nginx-net \
    -v /etc/certs:/etc/nginx/certs:ro \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy \
    jwilder/nginx-proxy:alpine
docker exec nginx-proxy sh -c " { echo \"client_max_body_size 512m;\"; } > /etc/nginx/conf.d/client_max_body_size.conf"