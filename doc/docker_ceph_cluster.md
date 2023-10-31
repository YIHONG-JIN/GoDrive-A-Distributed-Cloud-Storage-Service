Use docker to quickly deploy a small Ceph cluster for development and testing.
The installation process below is executed through the linux shell; assuming you only have one machine, with linux (such as Ubuntu) system and docker environment, you can refer to the following steps to install Ceph:
```bash
# 1. switch to root user, restart docker
su
systemctl restart docker
# 2. create a bridge network for ceph cluster
docker network create --driver bridge --subnet 172.20.0.0/16 ceph-network
docker network inspect ceph-network
# 3. delete old ceph containers
docker rm -f $(docker ps -a | grep ceph | awk '{print $1}')
# 4. clean old ceph files
rm -rf /www/ceph /var/lib/ceph/  /www/osd/
# 5. volume create related directories and modify permissions for mounting volume
mkdir -p /www/ceph /var/lib/ceph/osd /www/osd/
chown -R 64045:64045 /var/lib/ceph/osd/
chown -R 64045:64045 /www/osd/
# 6. create monitor node
docker run -itd --name monnode --network ceph-network --ip 172.20.0.10 -e MON_NAME=monnode -e MON_IP=172.20.0.10 -v /www/ceph:/etc/ceph ceph/mon
# 7. mark 3 osd nodes on the monitor node
docker exec monnode ceph osd create
docker exec monnode ceph osd create
docker exec monnode ceph osd create
# 8. create osd nodes
docker run -itd --name osdnode0 --network ceph-network -e CLUSTER=ceph -e WEIGHT=1.0 -e MON_NAME=monnode -e MON_IP=172.20.0.10 -v /www/ceph:/etc/ceph -v /www/osd/0:/var/lib/ceph/osd/ceph-0 ceph/osd 
docker run -itd --name osdnode1 --network ceph-network -e CLUSTER=ceph -e WEIGHT=1.0 -e MON_NAME=monnode -e MON_IP=172.20.0.10 -v /www/ceph:/etc/ceph -v /www/osd/1:/var/lib/ceph/osd/ceph-1 ceph/osd
docker run -itd --name osdnode2 --network ceph-network -e CLUSTER=ceph -e WEIGHT=1.0 -e MON_NAME=monnode -e MON_IP=172.20.0.10 -v /www/ceph:/etc/ceph -v /www/osd/2:/var/lib/ceph/osd/ceph-2 ceph/osd
# 9. add monitor node to cluster
docker run -itd --name monnode_1 --network ceph-network --ip 172.20.0.11 -e MON_NAME=monnode_1 -e MON_IP=172.20.0.11 -v /www/ceph:/etc/ceph ceph/mon
docker run -itd --name monnode_2 --network ceph-network --ip 172.20.0.12 -e MON_NAME=monnode_2 -e MON_IP=172.20.0.12 -v /www/ceph:/etc/ceph ceph/mon
# 10. add gateway node to cluster
docker run -itd --name gwnode --network ceph-network --ip 172.20.0.9 -p 9080:80 -e RGW_NAME=gwnode -v /www/ceph:/etc/ceph ceph/radosgw
# 11. check ceph cluster status
sleep 10 && docker exec monnode ceph -s
# 12. create user
docker exec -it gwnode radosgw-admin user create --uid=user1 --display-name=user1
```