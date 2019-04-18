# ubuntu_fsl
## FSL for X11 forward 
```
docker run -v yourpath:/root -v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --net=host -e USER=$USER -it <ubuntu_fsl:latest> fsl
```
