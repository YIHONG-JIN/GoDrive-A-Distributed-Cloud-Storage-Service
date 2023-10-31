## Use go-micro to test grpc communication

### install dependencies

```
sudo apt-get -y install autoconf automake libtool
```

### install protobuf

```
mkdir ./tmp && cd ./tmp
git clone https://github.com/google/protobuf
cd protobuf
./autogen.sh
./configure
make
sudo make install
```

### install grpc related packages

```
go get github.com/micro/go-web
go get -v github.com/micro/protobuf/{proto,protoc-gen-go}
go get -v github.com/micro/protoc-gen-micro

export LD_LIBRARY_PATH=/usr/local/lib
export PATH=$GOPATH/bin:$PATH
```

### generate go version proto

```
protoc --proto_path=proto --proto_path=/data/go/work/src --micro_out=proto --go_out=proto proto/hello/hello.proto
```