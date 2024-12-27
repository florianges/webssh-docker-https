# WebSSH Docker (over https)
This Docker image allows you to run a WebSSH server on an Alpine Linux system out of the box.

Supports the x86_64, ARMv7 and ARMv8a (ARM64) architectures out of the box.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You will need Docker installed on your system and generate RSA keys.

### Installing and Running

You can clone this repository, create keys and build the Docker image.  
```
$ git clone https://github.com/florianges/webssh-docker-https
$ cd webssh-docker-https
$ openssl genrsa 2048 > host.key
$ chmod 400 host.key
$ openssl req -new -x509 -nodes -sha256 -days 365 -key host.key -out host.cert
$ docker build -t webssh-docker-https .
```

### Running the image

You will need to expose one port in order to communicate with the WebSSH server.

```
docker run -d --name webssh-docker -p 4433:4433 webssh-docker-https
```
If you want to use HTTP, you need to expose port 8080.
