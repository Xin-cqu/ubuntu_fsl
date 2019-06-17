FROM centos:latest
MAINTAINER Xin Wen <nclxwen@gmail.com>
# Run everything in /root
WORKDIR /root

RUN yum -y update && yum clean all; \
	yum -y install curl libxcb1 libomp-dev libopenblas-dev bzip2 libx11-6

# Get the FSL Install Script
RUN curl -O -L https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py

# Install FSL
RUN python fslinstaller.py -d /usr/local/fsl -V 6.0.1

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
