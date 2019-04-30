#!/usr/bin/env bash
docker network create -d bridge nginx-net

docker run -d -p 80:80 -p 443:443 \
    --name nginx-proxy \
    -e ENABLE_IPV6=true \
    --restart unless-stopped \
    --network=nginx-net \
    -v /etc/certs:/etc/nginx/certs:rw \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    --label com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy \
    jwilder/nginx-proxy:alpine

docker exec nginx-proxy sh -c " { echo \"client_max_body_size 512m;fastcgi_read_timeout 1h;proxy_read_timeout 1h;\"; } > /etc/nginx/conf.d/client_max_body_size.conf"
#ssl for *.test domain
docker exec nginx-proxy sh -c " { echo \"-----BEGIN CERTIFICATE-----\";\
echo \"MIIC9TCCAd2gAwIBAgIJAJB9qHNwsrZYMA0GCSqGSIb3DQEBBQUAMBExDzANBgNV\";\
echo \"BAMMBioudGVzdDAeFw0xODA4MDcxOTI0NDNaFw0yODA4MDQxOTI0NDNaMBExDzAN\";\
echo \"BgNVBAMMBioudGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMaP\";\
echo \"LiwqRPCfp4ImYHqQiBJ0gGVr+kCwzPjuXbVyEvLeYE5wjJOwL0lnVeM8vo8iqRJ3\";\
echo \"aJSGkO/w0cWSZXkSCQGMTQOlK6UqMyuJnXqMQReN1IXTxRN9oFsi9NPOiDxXuJ97\";\
echo \"+/mtw7iwiNA28xZBN/AWjEinrglZDLIBGzeNCc6SApK5M6hwOb8eUXUduhbs7eGA\";\
echo \"Gl0kAQucTRRZ0JfVgnL3/M5Kcw5eFEQQ3IfaaPZ99RfCGTFEsOTOT5SjzPjP/8g2\";\
echo \"4cbYHAJ84ABfl+wdU64soT8tFaX2M8a2rP3RKVKoPj5RqIJQwog4QxKy7nflKznP\";\
echo \"WSO7UBg+nt2BUWRJ7f8CAwEAAaNQME4wHQYDVR0OBBYEFCGnrhbhxlNuunPTr4JW\";\
echo \"CfI0hPqOMB8GA1UdIwQYMBaAFCGnrhbhxlNuunPTr4JWCfI0hPqOMAwGA1UdEwQF\";\
echo \"MAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAB7fcMkNuAlgxheQuJqUV6DtBTpK+ZNE\";\
echo \"UwCv9Z20QVukinlOYYTFDQGSgIRuNgGo81rXMl8e5baZ9FcT1sYBCG3HPGxcwMet\";\
echo \"sIJ8sThqLikoYHAhKGD4yKmolsXk1SPk7lZ5obajHhjzzeHiNerrZkF0oCsCXLDJ\";\
echo \"uMu7ASxKDGjyeoxGYIE1M1q5c5JCWzgFu+Bzno4KOd/SzsNzEwYIlHq+aOaoB+2S\";\
echo \"lvMPvolhbcHUIHE+VfNG94sO7b6Tdaz0JgJITOLasfrYjyvfyQc5w8duJYiuSn/w\";\
echo \"VfUq5axUrf/IGif8raePc/2NH6aWtxsMPXvAQJPrkNu4+ewtMSmi/9U=\";\
echo \"-----END CERTIFICATE-----\"; } > /etc/nginx/certs/test.crt"
docker exec nginx-proxy sh -c " { echo \"-----BEGIN RSA PRIVATE KEY-----\";\
echo \"MIIEpAIBAAKCAQEAxo8uLCpE8J+ngiZgepCIEnSAZWv6QLDM+O5dtXIS8t5gTnCM\";\
echo \"k7AvSWdV4zy+jyKpEndolIaQ7/DRxZJleRIJAYxNA6UrpSozK4mdeoxBF43UhdPF\";\
echo \"E32gWyL0086IPFe4n3v7+a3DuLCI0DbzFkE38BaMSKeuCVkMsgEbN40JzpICkrkz\";\
echo \"qHA5vx5RdR26Fuzt4YAaXSQBC5xNFFnQl9WCcvf8zkpzDl4URBDch9po9n31F8IZ\";\
echo \"MUSw5M5PlKPM+M//yDbhxtgcAnzgAF+X7B1TriyhPy0VpfYzxras/dEpUqg+PlGo\";\
echo \"glDCiDhDErLud+UrOc9ZI7tQGD6e3YFRZEnt/wIDAQABAoIBABsx4RELeQW72CVr\";\
echo \"PCuNQBXG/w7lCxFxJaGyhAMl7JJ3Apm7sIVJzDAxhwHof/D6vk1ZLWmqRI+YXCLD\";\
echo \"OkKqxbEAlku5g5DLhtafsoHmU8P2GPV7W7KfsibJUt7vmpkpKpAtWwWHVxcklpht\";\
echo \"7j1OEWtAq1YIIT4GhEadAC1Lk9xGxPImtUg0OxrDIcBrrzdNT1bCNagfKJYSnIG/\";\
echo \"iUpGw7h2J6OTdCk7rdhmHreJv6I/+caxUJkw3MUxtScnKA9nPdXwVTeTlL5kvesp\";\
echo \"5AfGUrWm435ZoJq7WqFJatBM34dyWKr6NMxdAkUqZqayEetB2DZp5FODa8C3DIxj\";\
echo \"AyufYwECgYEA/+ms867ipO3cb6kseBYm0LNygRVX7Be4qh1B4j1a0BnW+HV3Ojux\";\
echo \"yDyJm3jyYbKP9EsShrXUHrsLBbsa7UX4jFiQO5fkTYdITFbAEnyFmrlbgwFFAhqT\";\
echo \"Sn5sP9d4UQT8TwBLu+SYdAT5E5bsh5FCHFf47JELpXlOJqdCsIe6xEcCgYEAxqCA\";\
echo \"ZssxTwcng7EXmYhnAiP4QOoc1OrmTQ0cLfWhFdmIJOzQuDuiDk8PCXP4QGukMPrq\";\
echo \"OwYfLK+CprAdM+6j9vBjQDJaIQUzxPLehHnK/RBhDpPHQCPqSanUWUAjdZ0E6kyL\";\
echo \"La8CRVL4ku6FW5GnEO2kYMhP28lMRQFSuCxX/IkCgYBX3f3aNYPwKRN061svaDuv\";\
echo \"kM2R8Kgdkg9/qUgDzBkwNo8PBBYJ0pE6NT7yONbQIKU4tcYIpsnMO2CPeSzHpyyt\";\
echo \"04LCU2a6D+cM/wQ31LVy6I25L2hoToOgIkQ8r1jKSLHw1iMqwlRuEX8L8NgJvCA8\";\
echo \"5x+66hpbmIjy0J8fSZsg5QKBgQCHVejnIV+xhyBnXIzF8eitzrBiGqIWeQ7+RQaE\";\
echo \"Ui614ogfELSOMyOSOE/4kun9itpO/UgHe35WRifxR2I+dkWGBfi6TxSWFyNU+F6h\";\
echo \"SRMEJtrawdorW81Q78ReI5OFmb01n33dXLdhYM054AdBgxagNCuiPhobmSa8hdBE\";\
echo \"6QHycQKBgQDUhDFBwWrDnjD7HyPe0QaeEY0ul3zy4Fqia0XBNF14OgqYD+MDZ4W4\";\
echo \"aevbWxs8etALkQdQRxxVuLSbh9QrAfkSJyIhUlPn+k3+0bMuRyewGHrJia7paMPj\";\
echo \"nuWNsdu84wT5ZnjzleFasddJbsY2GRozklVe6UdlXJSF0cfVwjR96Q==\";\
echo \"-----END RSA PRIVATE KEY-----\"; } > /etc/nginx/certs/test.key"
