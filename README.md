# Distributed-fileserver

A distributed cloud storage service based on Golang

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
