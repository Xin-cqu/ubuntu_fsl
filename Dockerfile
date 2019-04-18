FROM ubuntu:trusty
MAINTAINER Xin Wen <nclxwen@gmail.com>

RUN apt-get update && apt-get install -y wget curl vim python x11vnc xvfb
RUN wget -O- http://neuro.debian.net/lists/trusty.cn-zj.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
RUN sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
RUN sudo apt-get update
RUN apt-get install -y fsl-complete
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN     mkdir ~/.vnc
# Setup a password
RUN     x11vnc -storepasswd xwen ~/.vnc/passwd
# Autostart fsl (might not be the best way to do it, but it does the trick)
RUN     bash -c 'echo "fsl" >> /.bashrc'
# Configure environment
ENV FSLDIR=/usr/share/fsl/5.0
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV PATH=/usr/lib/fsl/5.0:$PATH
ENV FSLMULTIFILEQUIT=TRUE
ENV POSSUMDIR=/usr/share/fsl/5.0
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish
ENV FSLOUTPUTTYPE=NIFTI_GZ

#make it work under singularity
RUN ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft

#https://wiki.ubuntu.com/DashAsBinSh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
