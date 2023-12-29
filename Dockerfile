FROM carlomt/geant4:11.2.0-gui-jammy

LABEL maintainer="carlo.mancini-terracciano@uniroma1.it"
LABEL org.label-schema.name="carlomt/geant4course"
LABEL org.label-schema.url="https://github.com/carlomt/docker-geant4course"

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -yq --no-install-recommends install \
    less \
    wget \
    emacs \
    vim \
    ssh \
    && \
    apt-get -y autoremove && \
    apt-get -y clean && \    
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /usr/local/geant4/ && \
#     ln -s /opt/geant4/ /usr/local/geant4/geant4-${G4-VERSION}-install/

COPY makelink.sh /etc/profile.d/makelink.sh

ENTRYPOINT  ["/usr/bin/bash", "-l"]
