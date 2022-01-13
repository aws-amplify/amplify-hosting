FROM amazonlinux:2

# https://docs.docker.com/engine/reference/builder/#maintainer-deprecated
LABEL maintainer="Amazon AWS"

# Framework Versions
ENV VERSION_NODE_8=8.12.0
ENV VERSION_NODE_10=10.16.0
ENV VERSION_NODE_12=12
ENV VERSION_NODE_14=14
ENV VERSION_NODE_16=16
ENV VERSION_NODE_17=17
ENV VERSION_NODE_DEFAULT=$VERSION_NODE_14
ENV VERSION_RUBY_2_4=2.4.6
ENV VERSION_RUBY_2_6=2.6.3
ENV VERSION_BUNDLER=2.0.1
ENV VERSION_RUBY_DEFAULT=$VERSION_RUBY_2_4
ENV VERSION_HUGO=0.75.1
ENV VERSION_YARN=1.22.0
ENV VERSION_AMPLIFY=6.3.1

# UTF-8 Environment
ENV LANGUAGE en_US:en
ENV LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

## Install OS packages
RUN touch ~/.bashrc
RUN yum -y update && \
    yum -y install \
    alsa-lib-devel \
    autoconf \
    automake \
    bzip2 \
    bison \
    bzr \
    cmake \
    expect \
    fontconfig \
    git \
    gcc-c++ \
    GConf2-devel \
    gtk2-devel \
    gtk3-devel \
    libnotify-devel \
    libpng \
    libpng-devel \
    libffi-devel \
    libtool \
    libX11 \
    libXext \
    libxml2 \
    libxml2-devel \
    libXScrnSaver \
    libxslt \
    libxslt-devel \
    libyaml \
    libyaml-devel \
    make \
    nss-devel \
    openssl-devel \
    openssh-clients \
    patch \
    procps \
    python3 \
    python3-devel \
    readline-devel \
    sqlite-devel \
    tar \
    tree \
    unzip \
    wget \
    which \
    xorg-x11-server-Xvfb \
    zip \
    zlib \
    zlib-devel \
    yum clean all && \
    rm -rf /var/cache/yum

## Install Hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v${VERSION_HUGO}/hugo_${VERSION_HUGO}_Linux-64bit.tar.gz && \
    tar -xf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz hugo -C / && \
    mv /hugo /usr/bin/hugo && \
    rm -rf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz

## Install dotnet sdk and host 3.1
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
RUN yum -y install dotnet-host-3.1.4
RUN yum -y install dotnet-sdk-3.1

## Install amazon dotnet tools
RUN dotnet tool install -g Amazon.Lambda.Tools
RUN dotnet tool install -g Amazon.Lambda.TestTool-3.1

## Install python3.8
RUN wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
RUN tar xvf Python-3.8.0.tgz
WORKDIR Python-3.8.0
RUN ./configure --enable-optimizations --prefix=/usr/local
RUN make altinstall

## Install python3.9
RUN wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
RUN tar xvf Python-3.9.0.tgz
WORKDIR Python-3.9.0
RUN ./configure --enable-optimizations --prefix=/usr/local
RUN make altinstall

## Install Node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm install $VERSION_NODE_8 && nvm use $VERSION_NODE_8 && \
    nvm install $VERSION_NODE_10 && nvm use $VERSION_NODE_10 && \
    npm install -g yarn@${VERSION_YARN} sm grunt-cli bower vuepress gatsby-cli && \
    nvm install $VERSION_NODE_12 && nvm use $VERSION_NODE_12 && \
    npm install -g yarn@${VERSION_YARN} sm grunt-cli bower vuepress gatsby-cli && \
    nvm install $VERSION_NODE_14 && nvm use $VERSION_NODE_14 && \
    npm install -g yarn@${VERSION_YARN} sm grunt-cli bower vuepress gatsby-cli && \
    nvm install $VERSION_NODE_16 && nvm use $VERSION_NODE_16 && chown -R root:root /root/.nvm &&  \
    npm install -g yarn@${VERSION_YARN} sm grunt-cli bower vuepress gatsby-cli && \
    nvm install $VERSION_NODE_17 && nvm use $VERSION_NODE_17 && chown -R root:root /root/.nvm && \
    npm install -g yarn@${VERSION_YARN} sm grunt-cli bower vuepress gatsby-cli && \
    nvm alias default ${VERSION_NODE_DEFAULT} && nvm cache clear"

# Handle yarn for any `nvm install` in the future
RUN echo "yarn@${VERSION_YARN}" > /root/.nvm/default-packages

## Install Ruby 2.4.x and 2.6.x
## https://github.com/rvm/rvm/issues/5096 | https://rvm.io/rvm/security#install-our-keys - The old keyserver is no longer available
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import - && curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - && \
    curl -sL https://get.rvm.io | bash -s -- --with-gems="bundler"

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash --login -c "\
    rvm install $VERSION_RUBY_2_4 && rvm use $VERSION_RUBY_2_4 && gem install bundler -v $VERSION_BUNDLER && gem install jekyll && \
    rvm install $VERSION_RUBY_2_6 && rvm use $VERSION_RUBY_2_6 && gem install bundler -v $VERSION_BUNDLER && gem install -N jekyll && \
    rvm cleanup all"

## Install awscli
RUN /bin/bash -c "pip3.8 install awscli && rm -rf /var/cache/apk/*"
RUN /bin/bash -c "pip3.9 install awscli && rm -rf /var/cache/apk/*"

## Install SAM CLI
RUN /bin/bash -c "pip3.8 install aws-sam-cli"
RUN /bin/bash -c "pip3.9 install aws-sam-cli"

## Installing Cypress
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm use ${VERSION_NODE_DEFAULT} && \
    npm install -g --unsafe-perm=true --allow-root cypress"

## Install AWS Amplify CLI for all node versions
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_8} && \
    npm config set user 0 && npm config set unsafe-perm true && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_10} && \
    npm config set user 0 && npm config set unsafe-perm true && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_12} && \
    npm config set user 0 && npm config set unsafe-perm true && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_14} && \
    npm config set user 0 && npm config set unsafe-perm true && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_16} && \
    npm config set user 0 && npm config set unsafe-perm true && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_17}  && \
    npm config set user 0 && npm config set unsafe-perm true && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"

## Environment Setup
RUN echo export PATH="\
    /usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}/bin:\
    /usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}@global/bin:\
    /usr/local/rvm/rubies/ruby-${VERSION_RUBY_DEFAULT}/bin:\
    /usr/local/rvm/bin:\
    /root/.nvm/versions/node/${VERSION_NODE_DEFAULT}/bin:\
    $(python3 -m site --user-base)/bin:\
    $(python3.8 -m site --user-base)/bin:\
    $(python3.9 -m site --user-base)/bin:\
    $PATH" >> ~/.bashrc && \
    echo export GEM_PATH="/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}" >> ~/.bashrc && \
    echo "nvm use ${VERSION_NODE_DEFAULT} 1> /dev/null" >> ~/.bashrc && \
    echo "export PATH=\$PATH:/root/.dotnet/tools" >> ~/.bashrc

ENTRYPOINT [ "bash", "-c" ]
