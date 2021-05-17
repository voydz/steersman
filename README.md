# steersman

## Run it
```bash
#!/bin/bash
docker run --name steersman -d -p 8880:80 --device /dev/ttyACM0:/dev/ttyACM0 -v /path/to/your/config:/config steersman:latest
```