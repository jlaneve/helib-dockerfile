FROM gcc

RUN apt-get update
RUN apt-get install lzip

WORKDIR /
RUN wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz -O gmp
RUN tar --lzip -xvf gmp
WORKDIR gmp-6.1.2/
RUN ./configure
RUN make
RUN make install

WORKDIR /
RUN wget http://www.shoup.net/ntl/ntl-10.3.0.tar.gz -O ntl
RUN tar -xvf ntl
WORKDIR ntl-10.3.0/src/
RUN ./configure NTL_GMP_LIP=on
RUN make
RUN make install

WORKDIR /
RUN wget https://github.com/jlaneve/HElib/archive/v1.0.tar.gz -O HElib
RUN tar -xvf HElib
WORKDIR HElib-1.0/src/

COPY index.cpp /HElib-1.0/src/index.cpp
RUN make index_x
RUN ./index_x
