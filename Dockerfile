FROM dockerpedia/pegasus_workflow_images:pegasus-4.8.5

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Soybean Knowledge Base" \
      org.label-schema.description="The SoyKB  workflow is a genomics pipeline that re-sequences soybean germplasm lines selected for desirable traits such as oil, protein, soybean cyst nematode resistance, stress resistance, and root system architecture" \
      org.label-schema.url="http://www.soykb.org/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/dockerpedia/soykb" \
      org.label-schema.vendor="DockerPedia" \
      org.label-schema.version="1.0" \
      org.label-schema.schema-version="1.0"
      org.label-schema.docker.cmd="docker run -d -ti --name soybean mosorio/pegasus_workflow_images:soykb"

USER workflow

#Install SoyKb
RUN mkdir -p soykb/ && \
    mkdir -p soykb/wrappers/ && \
    wget https://github.com/rafaelfsilva/workflow-reproducibility/raw/master/components/soykb/soykb.tar.gz && \
    tar -xzf soykb.tar.gz && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/software.tar.gz && \
    tar -xzf software.tar.gz -C soykb/ && \
    cd ~/soykb/wrappers/ && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/picard-wrapper  && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/software-wrapper && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/gatk-wrapper && \
    wget https://raw.githubusercontent.com/rafaelfsilva/workflow-reproducibility/master/components/soykb/wrappers/bwa-wrapper && \
    chmod +X . && \
    wget https://gist.githubusercontent.com/sirspock/0446aeb932c63d08292f0ddcd21c9c37/raw/b61304486afeeda8a1e06342777b5c6e04c8f430/soybean-workflow.conf \
    -O ~/.soybean-workflow.conf && \
    ln -s ~/.ssh/id_rsa ~/.ssh/id_dsa && \
    ln -s ~/.ssh/id_rsa ~/.ssh/workflow && \
    rm /home/workflow/software.tar.gz /home/workflow/soykb.tar.gz

ADD workflow-generator soykb/

USER root
