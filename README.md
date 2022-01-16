# distributed-fileserver

A distributed cloud storage service based on Golang

## logic

<img src='/doc/microservice_interact_archi.png' width="800px"></img>

## manually install

as following：
```shell
go get github.com/garyburd/redigo/redis
go get github.com/go-sql-driver/mysql
#go get github.com/garyburd/redigo/redis
go get github.com/gomodule/redigo/redis
go get github.com/json-iterator/go
go get github.com/aliyun/aliyun-oss-go-sdk/oss
go get gopkg.in/amz.v1/aws
go get gopkg.in/amz.v1/s3
go get github.com/streadway/amqp
go get github.com/gin-gonic/gin
go get github.com/gin-contrib/cors
go get github.com/micro/go-micro
go get github.com/mitchellh/mapstructure
go get github.com/jteeuwen/go-bindata/...
go get github.com/moxiaomomo/go-bindata-assetfs/...
go get github.com/gin-gonic/contrib/static
go get github.com/micro/go-micro/cmd
go get github.com/micro/go-plugins/registry/kubernetes
go get -v github.com/micro/go-plugins/wrapper/breaker/hystrix
go get -v github.com/juju/ratelimit
go get -v github.com/micro/go-plugins/wrapper/ratelimiter/ratelimit
```

## How to start

```bash
> cd $GOPATH/filestore-server
# Start the container
> ./deploy/start-all.sh
# Shut down the container
> ./deploy/stop-all.sh
# start container with docker-compose
> cd ./deploy/service_dc
> sudo docker-compose up -d
# star microservices with k8s
> cd ./deploy/service_k8s
> kubectl apply -f svc_account.yaml
> kubectl apply -f svc_apigw.yaml
> kubectl apply -f svc_dbproxy.yaml
> kubectl apply -f svc_download.yaml
> kubectl apply -f svc_transfer.yaml
> kubectl apply -f svc_upload.yaml
> cd ./deploy/traefik_k8s
> kubectl apply -f service-ingress.yaml
```
