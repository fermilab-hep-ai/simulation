ARG BUILDER_IMAGE=ghcr.io/scipp-atlas/mapyde/delphes
FROM ${BUILDER_IMAGE} as builder
ARG DELPHES_VERSION=3.5.0
ARG LHAPDF_VERSION=6.3.0
ARG PYTHIA_VERSION=8310
ARG FASTJET_VERSION=3.3.4
ARG HEPMC_VERSION=2.06.11
ARG MG_VERSION=3.5.8
ARG MG_VERSION_=3_5_8
ARG MG_VERSION_x=3.5.x
ARG FASTJET_VERSION=3.3.4
ARG BOOST_VERSION=1.76.0
ARG MG5aMC_PY8_INTERFACE_VERSION=1.3
ARG PYTHON_VERSION=3.8.10
ARG COMMIT_HASH=6360ca8ed0ff018735e3bfbc815ea2c4b23adfa9

USER root
WORKDIR /usr/local

SHELL [ "/bin/bash", "-c" ]

RUN rm -rf /usr/local/share/delphes && \
    mkdir -p /usr/local/share/delphes && \
    cd /usr/local/share/delphes && \
    git clone https://github.com/fermilab-hep-ai/delphes.git -b ${DELPHES_VERSION}-puppiw Delphes-${DELPHES_VERSION} && \
    cd Delphes-${DELPHES_VERSION} && \
    git checkout ${COMMIT_HASH} && \
    make -j$(($(nproc) - 1)) && \
    cd ../ && \
    ln -s Delphes-${DELPHES_VERSION} ./delphes

ENV DELPHES_PATH="/usr/local/share/delphes/delphes"
ENV ROOT_INCLUDE_PATH=${ROOT_INCLUDE_PATH}:${DELPHES_PATH}:${DELPHES_PATH}/external

RUN apt-get -qq -y update && \
    apt-get -qq -y install \
    gcc \
    g++ \
    gfortran \
    make \
    vim \
    cmake \
    bc \
    zlibc \
    zlib1g-dev \
    libbz2-dev \
    rsync \
    curl \
    bash-completion \
    python3-dev \
    less \
    coreutils \
    libboost-all-dev \
    wget && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install HepMC
RUN mkdir /code && \
    cd /code && \
    wget --no-check-certificate http://hepmc.web.cern.ch/hepmc/releases/hepmc${HEPMC_VERSION}.tgz && \
    tar xvfz hepmc${HEPMC_VERSION}.tgz && \
    mv HepMC-${HEPMC_VERSION} src && \
    cmake \
    -DCMAKE_CXX_COMPILER=$(command -v g++) \
    -DCMAKE_BUILD_TYPE=Release \
    -Dbuild_docs:BOOL=OFF \
    -Dmomentum:STRING=MEV \
    -Dlength:STRING=MM \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -S src \
    -B build && \
    cmake build -L && \
    cmake --build build -- -j$(($(nproc) - 1)) && \
    cmake --build build --target install && \
    rm -rf /code

# Install FastJet
RUN mkdir /code && \
    cd /code && \
    wget --no-check-certificate http://fastjet.fr/repo/fastjet-${FASTJET_VERSION}.tar.gz && \
    tar xvfz fastjet-${FASTJET_VERSION}.tar.gz && \
    cd fastjet-${FASTJET_VERSION} && \
    ./configure --help && \
    export CXX=$(command -v g++) && \
    export PYTHON=$(command -v python3) && \
    export PYTHON_CONFIG=/usr/bin/python-config && \
    ./configure \
    --prefix=/usr/local \
    --enable-pyext=yes && \
    make -j$(($(nproc) - 1)) && \
    make check && \
    make install && \
    rm -rf /code


# Install LHAPDF
RUN mkdir /code && \
    cd /code && \
    wget --no-check-certificate https://lhapdf.hepforge.org/downloads/?f=LHAPDF-${LHAPDF_VERSION}.tar.gz -O LHAPDF-${LHAPDF_VERSION}.tar.gz && \
    tar xvfz LHAPDF-${LHAPDF_VERSION}.tar.gz && \
    cd LHAPDF-${LHAPDF_VERSION} && \
    ./configure --help && \
    export CXX=$(command -v g++) && \
    export PYTHON=$(command -v python3) && \
    ./configure \
    --prefix=/usr/local && \
    make -j$(($(nproc) - 1)) && \
    make install && \
    chmod a+w /usr/local/share/LHAPDF/ && \
    rm -rf /code

# Install PYTHIA
RUN mkdir /code && \
    cd /code && \
    wget --no-check-certificate "https://pythia.org/download/pythia${PYTHIA_VERSION:0:2}/pythia${PYTHIA_VERSION}.tgz" && \
    tar xvfz pythia${PYTHIA_VERSION}.tgz && \
    cd pythia${PYTHIA_VERSION} && \
    ./configure --help && \
    export PYTHON_MINOR_VERSION="${PYTHON_VERSION%.*}" && \
    ./configure \
    --prefix=/usr/local \
    --arch=Linux \
    --cxx=g++ \
    --enable-64bit \
    --with-gzip \
    --with-hepmc2=/usr/local \
    --with-lhapdf6=/usr/local \
    --with-fastjet3=/usr/local \
    --with-python-bin=/usr/bin \
    --with-python-lib=/usr/lib/python${PYTHON_MINOR_VERSION} \
    --with-python-include=/usr/include/python${PYTHON_MINOR_VERSION} \
    --cxx-common="-O2 -m64 -pedantic -W -Wall -Wshadow -fPIC -std=c++11" \
    --cxx-shared="-shared -std=c++11 -lpthread" && \
    make -j$(($(nproc) - 1)) && \
    make install && \
    rm -rf /code

# Install BOOST
# c.f. https://www.boost.org/doc/libs/1_76_0/more/getting_started/unix-variants.html
# hadolint ignore=SC2046
RUN mkdir -p /code && \
    cd /code && \
    BOOST_VERSION_UNDERSCORE="${BOOST_VERSION//\./_}" && \
    curl --silent --location --remote-name "https://archives.boost.io/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_UNDERSCORE}.tar.gz" && \
    tar -xzf "boost_${BOOST_VERSION_UNDERSCORE}.tar.gz" && \
    cd "boost_${BOOST_VERSION_UNDERSCORE}" && \
    ./bootstrap.sh --help && \
    ./bootstrap.sh \
    --prefix=/usr/local \
    --with-python=$(command -v python3) && \
    ./b2 install -j$(($(nproc) - 1)) && \
    cd / && \
    rm -rf /code


# Install MadGraph5_aMC@NLO for Python 3
RUN cd /usr/local && \
    wget --no-check-certificate https://launchpad.net/mg5amcnlo/3.0/${MG_VERSION_x}/+download/MG5_aMC_v${MG_VERSION}.tar.gz && \
    tar -xzf MG5_aMC_v${MG_VERSION}.tar.gz && \
    chmod -R a+w /usr/local/MG5_aMC_v${MG_VERSION_}/ && \
    rm MG5_aMC_v${MG_VERSION}.tar.gz && \
    echo "Patching madevent_interface.py" && \
    cd /usr/local/MG5_aMC_v${MG_VERSION_}/ && \
    wget --no-check-certificate https://github.com/mg5amcnlo/mg5amcnlo/commit/1cec098c51d8f3e5823c33d3dd06048825934d20.patch && \
    git apply 1cec098c51d8f3e5823c33d3dd06048825934d20.patch && \
    rm 1cec098c51d8f3e5823c33d3dd06048825934d20.patch && \
    echo "Installing MG5aMC_PY8_interface" && \
    mkdir /code && \
    cd /code && \
    wget --quiet http://madgraph.phys.ucl.ac.be/Downloads/MG5aMC_PY8_interface/MG5aMC_PY8_interface_V${MG5aMC_PY8_INTERFACE_VERSION}.tar.gz && \
    mkdir -p /code/MG5aMC_PY8_interface && \
    tar -xzf MG5aMC_PY8_interface_V${MG5aMC_PY8_INTERFACE_VERSION}.tar.gz --directory=MG5aMC_PY8_interface && \
    cd MG5aMC_PY8_interface && \
    python3 compile.py /usr/local --pythia8_makefile /usr/local/MG5_aMC_v${MG_VERSION_} && \
    echo "hi" && \
    mkdir -p /usr/local/MG5_aMC_v${MG_VERSION_}/HEPTools/MG5aMC_PY8_interface && \
    cp *.h /usr/local/MG5_aMC_v${MG_VERSION_}/HEPTools/MG5aMC_PY8_interface/ && \
    cp *_VERSION_ON_INSTALL /usr/local/MG5_aMC_v${MG_VERSION_}/HEPTools/MG5aMC_PY8_interface/ && \
    cp MG5aMC_PY8_interface /usr/local/MG5_aMC_v${MG_VERSION_}/HEPTools/MG5aMC_PY8_interface/ && \
    rm -rf /code

# Change the MadGraph5_aMC@NLO configuration settings
RUN sed -i '/fastjet =/s/^# //g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt && \
    sed -i '/lhapdf_py3 =/s/^# //g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt && \
    sed -i 's|# pythia8_path.*|pythia8_path = /usr/local|g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt && \
    sed -i 's|# delphes_path.*|delphes_path = /usr/local/share/delphes/delphes|g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt && \
    sed -i '/mg5amc_py8_interface_path =/s/^# //g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt && \
    sed -i 's|# eps_viewer.*|eps_viewer = '$(command -v ghostscript)'|g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt && \
    sed -i 's|# fortran_compiler.*|fortran_compiler = '$(command -v gfortran)'|g' /usr/local/MG5_aMC_v${MG_VERSION_}/input/mg5_configuration.txt

# Enable tab completion by uncommenting it from /etc/bash.bashrc
# The relevant lines are those below the phrase "enable bash completion in interactive shells"
RUN export SED_RANGE="$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+1)),$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+7))" && \
    sed -i -e "${SED_RANGE}"' s/^#//' /etc/bash.bashrc && \
    unset SED_RANGE

# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV HOME /home/docker
WORKDIR ${HOME}/data
RUN cp /root/.profile ${HOME}/.profile && \
    cp /root/.bashrc ${HOME}/.bashrc && \
    echo "" >> ${HOME}/.bashrc && \
    echo "export MG_VERSION_=${MG_VERSION_}" && \
    echo 'export PATH=${HOME}/.local/bin:$PATH' >> ${HOME}/.bashrc && \
    echo 'export PATH=/usr/local/MG5_aMC_v${MG_VERSION_}/bin:$PATH' >> ${HOME}/.bashrc && \
    echo 'alias ls="ls -ltrh --color"' >> ${HOME}/.bashrc && \
    python3 -m pip install --upgrade --no-cache-dir pip setuptools wheel && \
    python3 -m pip install --no-cache-dir six numpy matplotlib uproot pyyaml pyarrow pandas

ENV PYTHONPATH=/usr/local/lib:$PYTHONPATH
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV PATH ${HOME}/.local/bin:$PATH
ENV MG_VERSION_ "${MG_VERSION_}"
ENV PATH /usr/local/MG5_aMC_v${MG_VERSION_}/bin:$PATH

# Add models
RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/models && \
    wget --no-check-certificate http://madgraph.physics.illinois.edu/Downloads/models//mssm_v4.tgz && \
    tar -zxvf mssm_v4.tgz

RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/models && \
    wget --no-check-certificate http://madgraph.physics.illinois.edu/Downloads/models/heft.tgz && \
    tar -zxvf heft.tgz

RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/models && \
    wget --no-check-certificate http://madgraph.physics.illinois.edu/Downloads/models/loop_qcd_qed_sm.tgz && \
    tar -zxvf loop_qcd_qed_sm.tgz

RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/models && \
    wget --no-check-certificate http://feynrules.irmp.ucl.ac.be/raw-attachment/wiki/RPVMSSM/af1_ufo.tgz && \
    tar -zxvf af1_ufo.tgz

RUN echo "convert model /usr/local/MG5_aMC_v${MG_VERSION_}/models/heft" | mg5_aMC && \
    echo "convert model /usr/local/MG5_aMC_v${MG_VERSION_}/models/loop_qcd_qed_sm" | mg5_aMC && \
    echo "convert model /usr/local/MG5_aMC_v${MG_VERSION_}/models/RPVMSSM_UFO" | mg5_aMC && \
    echo "install ninja" | mg5_aMC

# Add restriction
ADD docker/restrict_ckm_no_b_mass.dat /usr/local/MG5_aMC_v${MG_VERSION_}/models/sm/restrict_ckm_no_b_mass.dat

# Add hgg_plugin models
ADD models/sm__hgg_plugin /usr/local/MG5_aMC_v${MG_VERSION_}/models/sm__hgg_plugin
ADD models/sm-c_mass__hgg_plugin /usr/local/MG5_aMC_v${MG_VERSION_}/models/sm-c_mass__hgg_plugin
ADD models/sm-no_b_mass__hgg_plugin /usr/local/MG5_aMC_v${MG_VERSION_}/models/sm-no_b_mass__hgg_plugin

# build cuttools
RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/vendor/CutTools && \
    make clean && \
    make

# build iregi
RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/vendor/IREGI/src && \
    make clean && \
    make

# build StdHEP
RUN cd /usr/local/MG5_aMC_v${MG_VERSION_}/vendor/StdHEP && \
    make

# install PDF sets we commonly use
RUN python3 /usr/local/bin/lhapdf list --pdfdir /usr/local/share/LHAPDF --listdir /usr/local/share/LHAPDF
RUN python3 /usr/local/bin/lhapdf install NNPDF30_nlo_as_0118 --pdfdir /usr/local/share/LHAPDF --listdir /usr/local/share/LHAPDF
RUN python3 /usr/local/bin/lhapdf install NNPDF23_nlo_as_0119_qed --pdfdir /usr/local/share/LHAPDF --listdir /usr/local/share/LHAPDF
RUN python3 /usr/local/bin/lhapdf install NNPDF23_lo_as_0130_qed --pdfdir /usr/local/share/LHAPDF --listdir /usr/local/share/LHAPDF
RUN python3 /usr/local/bin/lhapdf install NNPDF31_nnlo_hessian_pdfas --pdfdir /usr/local/share/LHAPDF --listdir /usr/local/share/LHAPDF

# make it easier for users to modify things in the MG installation later
RUN chown -R root:root /usr/local/MG5_aMC_v${MG_VERSION_}/
RUN chmod -R a+w       /usr/local/MG5_aMC_v${MG_VERSION_}/
RUN chmod    a+x       $(find /usr/local/ -name pythia8-config)

# Download and install Lua 5.4.7 from source
RUN curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz && \
    tar zxf lua-5.4.7.tar.gz && \
    rm lua-5.4.7.tar.gz && \
    cd lua-5.4.7 && \
    make && \
    make install INSTALL_TOP=/ && \
    cd .. && \
    rm -r lua-5.4.7
# Clone and install luaposix in the correct location
RUN git clone https://github.com/luaposix/luaposix.git && \
    cd luaposix && \
    lua build-aux/luke LUA=/bin/lua LUA_INCDIR=/include PREFIX=/usr INST_LIBDIR=/usr/lib64/lua/5.4 INST_LUADIR=/usr/share/lua/5.4 && \
    lua build-aux/luke LUA=/bin/lua LUA_INCDIR=/include PREFIX=/usr INST_LIBDIR=/usr/lib64/lua/5.4 INST_LUADIR=/usr/share/lua/5.4 install && \
    cd .. && \
    rm -r luaposix
# Clone, configure and install luafilesystem in the correct location
RUN git clone https://github.com/lunarmodules/luafilesystem.git && \
    cd luafilesystem && \
    CONFIG_FILE="config" && \
    NEW_PREFIX="/usr" && \
    NEW_LUA_VERSION="5.4" && \
    NEW_LUA_LIBDIR="${NEW_PREFIX}/lib64/lua/${NEW_LUA_VERSION}" && \
    sed -i "s|^PREFIX=.*|PREFIX=${NEW_PREFIX}|" "$CONFIG_FILE" && \
    sed -i "s|^LUA_VERSION *=.*|LUA_VERSION = ${NEW_LUA_VERSION}|" "$CONFIG_FILE" && \
    sed -i "s|^LUA_LIBDIR=.*|LUA_LIBDIR= ${NEW_LUA_LIBDIR}|" "$CONFIG_FILE" && \
    sed -i 's|^LUA_INC += -I$(PREFIX)/include|LUA_INC += -I$(PREFIX)/include -I/include|' "$CONFIG_FILE" && \
    make && \
    make install && \
    cd .. && \
    rm -r luafilesystem

ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/bin/bash"]
