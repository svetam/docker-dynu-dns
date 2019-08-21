## docker-dynu-dns

This Alpine/Debian Linux based Docker image uses dynu.com service IP protocol to update dynamic DNS records.

### Setup

```sh
docker run --name=dynu-dns --restart=always \
-e HOST=... \
-e USER=... \
-e PASSWORD=... \
svetam/docker-dynu-dns
```

This will create container and set its `restart` policy to `always`. This means that container will be automatically started on startup and in a case of error. To stop service use `docker stop <name>`.

To run container on `armv7` architectures use `svetam/docker-dynu-dns:arm32v7` image. This is tested and working on WD MyCloud EX2 Ultra. 

`:latest` is tested on `Mac OS`
`:arm32v7` is tested on `WD MyCloud EX2 Ultra`

### Envitonmental variables

| var | description |
| ------ | ------ |
| USER | Username for the dynu service |
| PASSWORD | Password or MD5(password) or sha256(password) for the dynu service |
| HOST | The hostname that you are updating. ie. example.dynu.net |
| LOCATION | The location that you are updating. This is used to update multiple hostnames at the same time. |
| INTERVAL | How often the script will fetch public IP address in seconds. |

For more information check [dynu IP protocol documentation](https://www.dynu.com/en-US/DynamicDNS/IP-Update-Protocol)

MIT License Copyright (c) 2019 Svetislav Marković