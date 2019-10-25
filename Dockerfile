FROM nvidia/cuda:10.1-devel-ubuntu18.04
WORKDIR /src

SHELL [ "/bin/bash", "-c" ]
RUN apt-get update -y &&\
    apt-get -y install g++ wget git &&\
    wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh -O ~/anaconda.sh &&\
    mkdir ~/.conda &&\
    /bin/bash ~/anaconda.sh -b -p /opt/conda &&\
    rm ~/anaconda.sh &&\
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh &&\
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc &&\
    . ~/.bashrc
 
ENV PATH=/opt/conda/bin:$PATH
RUN conda update -n base -c defaults conda &&\
    conda create -y -c rdkit -n my-rdkit-env rdkit &&\
    conda install -y faiss-gpu cudatoolkit=10.0 -c pytorch
RUN apt-get install liblas-dev liblapack-dev libopenblas-base libomp-dev libfontconfig1 libxrender1 make swig nvidia-384 -y
RUN git clone https://github.com/bittremieux/ANN-SoLo.git

WORKDIR /app
RUN echo "conda activate my-rdkit-env" >> ~/.bashrc &&\
    echo "conda install -y faiss-gpu cudatoolkit=10.0 -c pytorch" >> ~/.bashrc &&\
    echo "cd /src/ANN-SoLo/src" >> ~/.bashrc &&\
    echo "python -m setup build" >> ~/.bashrc &&\
    echo "python -m setup install" >> ~/.bashrc &&\
    echo "cd /app" >> ~/.bashrc
ENTRYPOINT [ "/bin/bash" ]