FROM docker.jolibrain.com/deepdetect_cpu

USER root

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update -y \
 && apt-get install -y curl

USER dd

COPY setup.sh /opt/
COPY entrypoint.sh /opt/

ENTRYPOINT ["/opt/entrypoint.sh"]