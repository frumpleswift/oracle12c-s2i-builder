# oracle12c-s2i-builder
FROM oracle/database:12.1.0.2-ee

# TODO: Put the maintainer name in the image metadata
MAINTAINER Jonathan Hill <anfechtung@gmail.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building an oracle 12c pluggable database and deploy git code" \
      io.k8s.display-name="builder oracle 12c"  \
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,x.y.z,etc."
       io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" 

#Mimic s2i folder structure for OEL Oracle image
USER root

RUN mkdir -p /opt/app-root && \
mkdir /usr/libexec/s2i && \
chown -R oracle:dba /opt/app-root 

ENV PATH="${PATH}:/usr/libexec/s2i"

#Copy the modified runOracle script to the proper folder
COPY ./runOracle.sh /opt/oracle/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i


# This default user is created in the openshift/base-centos7 image
USER oracle

WORKDIR  /opt/app-root/

# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["usage"]
