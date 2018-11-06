FROM dockerpedia/pegasus_workflow_images:pegasus-4.8.5

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

USER root