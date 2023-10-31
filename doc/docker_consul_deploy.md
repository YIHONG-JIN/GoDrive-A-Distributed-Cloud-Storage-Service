## Use docker to deploy service registration center consul

### current version

docker: docker-ce18.06
consul: 1.4.2

### configuration options for consul

```
"-net=host" Docker parameter allows the Docker container to bypass network namespace isolation, eliminating the need for manually specifying port mappings.

"-server" Consul supports running in server or client mode. The server mode is the core of the service discovery module, while the client mode is primarily used for forwarding requests.

"-advertise" passes the private IP of the local machine to Consul.

"-retry-join" specifies the address of the Consul node to join. It will retry in case of failure, and you can specify multiple addresses.

"-client" specifies the client address to which Consul binds. This address provides HTTP, DNS, RPC, and other services. The default is 127.0.0.1.

"-bind" binds the server's IP address. This address is used for internal communication within the cluster, and all nodes in the cluster must be reachable at this address. The default is 0.0.0.0.

"-allow_stale" set to true indicates that DNS information can be obtained from any server node in the Consul cluster. Set to false, and every request will go through the Consul server leader.

"-bootstrap-expect" specifies the expected number of servers in the data center. After providing this, Consul will wait for the specified number of servers to become available and then start the cluster. It allows automatic leader election but cannot be used with the traditional "-bootstrap" flag and needs to run in server mode.

"-data-dir" is the location for storing data, used for persistently maintaining the cluster's state.

"-node" is the name of this node in the cluster, which must be unique within the cluster and defaults to the hostname of the node.

"-config-dir" specifies a configuration directory. When files with a .json extension are found in this directory, they are loaded. For more details, you can refer to https://www.consul.io/docs/agent/options.html#configuration_files.

"-enable-script-checks" checks if services are active, similar to enabling heartbeats.

"-datacenter" is the name of the data center.

"-ui" enables the UI interface.

"-join" joins an existing cluster.
```

### consul port

```
8500: HTTP port, used for HTTP interface and web UI access.

8300: Server RPC port, used for communication between Consul servers in the same data center through this port.

8301: Serf LAN port, used for communication between Consul clients in the same data center through this port; used to handle LAN gossip within the current data center.

8302: Serf WAN port, used for communication between Consul servers in different data centers through this port; used by agent servers to handle gossip with other data centers.

8600: DNS port, used for registered service discovery.
```


### start the first server node

```shell
docker run --name consul1 -d -p 8500:8500 -p 8300:8300 -p 8301:8301 -p 8302:8302 -p 8600:8600 consul agent -server -bootstrap-expect 2 -ui -bind=0.0.0.0 -client=0.0.0.0
```

### start the second server node and join the consul



- check the ip address of the first server node

```shell
$docker inspect --format '{{ .NetworkSettings.IPAddress }}' consul1
172.17.0.2
```

- start the second server node and join the consul

```shell
docker run --name consul2 -d -p 8501:8500 consul agent -server -ui -bind=0.0.0.0 -client=0.0.0.0 -join 172.17.0.2
```

### start the third server node and join the consul

```shell
docker run --name consul3 -d -p 8502:8500 consul agent -server -ui -bind=0.0.0.0 -client=0.0.0.0 -join 172.17.0.2
```

### check the status of the consul cluster

```shell
$docker exec -it consul1 consul members
Node          Address          Status  Type    Build  Protocol  DC   Segment
0392bb73a784  172.17.0.3:8301  alive   server  1.4.2  2         dc1  <all>
39ce8be84203  172.17.0.4:8301  alive   server  1.4.2  2         dc1  <all>
c8e93300cf75  172.17.0.2:8301  alive   server  1.4.2  2         dc1  <all>
```

### ui

`http://localhost:8500`

