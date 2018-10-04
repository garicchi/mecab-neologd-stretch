FROM python:3.6.5-stretch

WORKDIR /

RUN apt-get update&&apt-get upgrade -y
RUN apt-get install -y sudo

RUN mkdir /opt/cache

WORKDIR /opt
RUN git clone --verbose --progress --depth 1 https://github.com/taku910/mecab.git
WORKDIR /opt/mecab/mecab
RUN ./configure  --enable-utf8-only \
  && make \
  && make check \
  && make install \
  && ldconfig

WORKDIR /opt/mecab/mecab-ipadic

RUN ./configure --with-charset=utf8&& make&&make install

WORKDIR /opt

RUN git clone --verbose --progress --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git

WORKDIR /opt/mecab-ipadic-neologd

RUN ./bin/install-mecab-ipadic-neologd -n -y

WORKDIR /

CMD ["/bin/bash"]
