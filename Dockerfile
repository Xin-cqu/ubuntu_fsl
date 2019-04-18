FROM nvidia/cuda:8.0-runtime
MAINTAINER Xin Wen <nclxwen@gmail.com>
# Run everything in /root
WORKDIR /root

RUN apt-get -y update; \
	apt-get -y install curl python2.7 libxcb1 libomp-dev libopenblas-dev

# Get the FSL Install Script
RUN curl -O -L https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py

# Install FSL
RUN python2.7 fslinstaller.py -d /usr/local/fsl -V 6.0.1

# Setup Shell environment for FSL
ENV FSLDIR=/usr/local/fsl

# Setup FSL Defaults
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV FSLMULTIFILEQUIT=TRUE
ENV FSLTCLSH=$FSLDIR/bin/fsltclsh
ENV FSLWISH=$FSLDIR/bin/fslwish
ENV FSLLOCKDIR=
ENV FSLMACHINELIST=
ENV FSLREMOTECALL=

ENV PATH=${FSLDIR}/bin:${PATH}
ENV export FSLDIR PATH
RUN ldconfig

RUN export uid=xwen gid=xwen && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer


#https://wiki.ubuntu.com/DashAsBinSh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
USER developer
ENV HOME /home/developer
CMD /usr/bin/fsl
