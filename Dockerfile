FROM alvin2ye/ubuntu-1404-aliyun
MAINTAINER Alvin Ye <alvin.ye.cn@gmail.com>

RUN apt-get install -y wget build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev
RUN cd && mkdir install_ruby_ree_187 && cd install_ruby_ree_187  && \
curl -O http://agi-public3.qiniudn.com/20160606105850/ruby-enterprise-1.8.7-2012.02.tar.gz && \
tar xzf ruby-enterprise-1.8.7-2012.02.tar.gz && cd ruby-enterprise-1.8.7-2012.02 && \
cd ./source && \
wget 'https://github.com/wayneeseguin/rvm/raw/master/patches/ree/1.8.7/tcmalloc.patch' && \
patch -p1 < tcmalloc.patch && \
wget 'https://github.com/wayneeseguin/rvm/raw/master/patches/ree/1.8.7/stdout-rouge-fix.patch' && \
patch -p1 < stdout-rouge-fix.patch && \
wget 'https://github.com/wayneeseguin/rvm/raw/master/patches/ree/1.8.7/no_sslv2.diff' && \
patch -p1 < no_sslv2.diff ; \
wget 'https://github.com/wayneeseguin/rvm/raw/master/patches/ruby/ssl_no_ec2m.patch' && \
patch -p1 < ssl_no_ec2m.patch && \
wget 'https://github.com/wayneeseguin/rvm/raw/master/patches/ree/1.8.7/p358-p374.patch' && \
patch -p1 < p358-p374.patch ; \
wget 'https://github.com/wayneeseguin/rvm/raw/master/patches/ruby/GH-488.patch' && \
patch -p1 < GH-488.patch && \
cd .. && CFLAGS="-O2 -fno-tree-dce -fno-optimize-sibling-calls" CONFIGURE_OPTS="--no-tcmalloc" ./installer --auto /opt/ruby-ree-187 --dont-install-useful-gems

ENV PATH /opt/ruby-ree-187/bin:$PATH
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
