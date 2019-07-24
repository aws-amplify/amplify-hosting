# Use the standard Amazon Linux base, provided by ECR/KaOS
# It points to the standard shared Amazon Linux image, with a versioned tag.
FROM amazonlinux:1
MAINTAINER Amazon AWS

# Framework Versions
ENV VERSION_NODE_8=8.12.0
ENV VERSION_NODE_6=6
ENV VERSION_NODE_10=10
ENV VERSION_NODE_DEFAULT=$VERSION_NODE_8
ENV VERSION_RUBY_2_3=2.3.6
ENV VERSION_RUBY_2_4=2.4.3
ENV VERSION_RUBY_DEFAULT=$VERSION_RUBY_2_3
ENV VERSION_HUGO=0.51
ENV VERSION_YARN=1.13.0
ENV VERSION_AMPLIFY=1.7.0

# UTF-8 Environment
ENV LANGUAGE en_US:en
ENV LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

## Install OS packages
RUN touch ~/.bashrc
RUN yum -y update && \
    yum -y install \
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
        libpng \
        libpng-devel \
        libffi-devel \
        libtool \
        libX11 \
        libXext \
        libxml2 \
        libxml2-devel \
        libxslt \
        libxslt-devel \
        libyaml \
        libyaml-devel \
        openssl-devel \
        openssh-clients \
        patch \
        procps \
        python34 \
        python34-devel \
        python34-pip \
        readline-devel \
        sqlite-devel \
        tar \
        tree \
        unzip \
        wget \
        which \
        zip \
        zlib \
        zlib-devel \
    yum clean all && \
    rm -rf /var/cache/yum

## Install Node 6 & 8 & 10
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN curl -o- -L https://yarnpkg.com/install.sh > /usr/local/bin/yarn-install.sh
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm install $VERSION_NODE_6 && nvm use $VERSION_NODE_6 && \
	nvm install $VERSION_NODE_10 && nvm use $VERSION_NODE_10 && \
	nvm install $VERSION_NODE_8 && nvm use $VERSION_NODE_8 && \
	npm install -g sm grunt-cli bower vuepress gatsby-cli && \
	bash /usr/local/bin/yarn-install.sh --version $VERSION_YARN && \
	nvm alias default node && nvm cache clear"

## Install Ruby 2.3.x and 2.4.x
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys D39DC0E3 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
	curl -sL https://get.rvm.io | bash -s stable --with-gems="bundler"

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash --login -c "\
	rvm install $VERSION_RUBY_2_3 && rvm use $VERSION_RUBY_2_3 && gem install bundler -v 1.17.3 && gem install jekyll && \
	rvm install $VERSION_RUBY_2_4 && rvm use $VERSION_RUBY_2_4 && gem install bundler -v 1.17.3 && gem install jekyll && \
	rvm cleanup all"

## Install awscli
RUN /bin/bash -c "\
    mv /usr/bin/python /usr/bin/python2 && \
	ln -s /usr/bin/python3 /usr/bin/python && \
	pip-3.4 install awscli && rm -rf /var/cache/apk/*"

## Install Hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v${VERSION_HUGO}/hugo_${VERSION_HUGO}_Linux-64bit.tar.gz && \
    tar -xf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz hugo -C / && \
    mv /hugo /usr/bin/hugo && \
    rm -rf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz

## Install AWS Amplify CLI for VERSION_NODE_DEFAULT and VERSION_NODE_10
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_DEFAULT} && \
	npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_10} && \
	npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"

## Environment Setup
RUN echo export PATH="\
/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}/bin:\
/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}@global/bin:\
/usr/local/rvm/rubies/ruby-${VERSION_RUBY_DEFAULT}/bin:\
/usr/local/rvm/bin:\
/root/.yarn/bin:\
/root/.config/yarn/global/node_modules/.bin:\
/root/.nvm/versions/node/${VERSION_NODE_DEFAULT}/bin:\
$PATH" >> ~/.bashrc && \
    echo export GEM_PATH="/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}" >> ~/.bashrc && \
    echo "nvm use ${VERSION_NODE_DEFAULT} 1> /dev/null" >> ~/.bashrc

ENTRYPOINT [ "bash", "-c" ]

# Use the standard Amazon Linux base, provided by ECR/KaOS
# It points to the standard shared Amazon Linux image, with a versioned tag.
FROM 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:1
MAINTAINER Amazon AWS

# Framework Versions
ENV VERSION_NODE_8=8.12.0
ENV VERSION_NODE_6=6
ENV VERSION_NODE_10=10
ENV VERSION_NODE_DEFAULT=$VERSION_NODE_8
ENV VERSION_RUBY_2_3=2.3.6
ENV VERSION_RUBY_2_4=2.4.3
ENV VERSION_RUBY_DEFAULT=$VERSION_RUBY_2_3
ENV VERSION_HUGO=0.51
ENV VERSION_YARN=1.13.0
ENV VERSION_AMPLIFY=1.7.0

# UTF-8 Environment
ENV LANGUAGE en_US:en
ENV LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

## Install OS packages
RUN touch ~/.bashrc
RUN yum -y update && \
    yum -y install \
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
        libpng \
        libpng-devel \
        libffi-devel \
        libtool \
        libX11 \
        libXext \
        libxml2 \
        libxml2-devel \
        libxslt \
        libxslt-devel \
        libyaml \
        libyaml-devel \
        openssl-devel \
        openssh-clients \
        patch \
        procps \
        python34 \
        python34-devel \
        python34-pip \
        readline-devel \
        sqlite-devel \
        tar \
        tree \
        unzip \
        wget \
        which \
        zip \
        zlib \
        zlib-devel \
    yum clean all && \
    rm -rf /var/cache/yum

## Install Node 6 & 8 & 10
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN curl -o- -L https://yarnpkg.com/install.sh > /usr/local/bin/yarn-install.sh
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm install $VERSION_NODE_6 && nvm use $VERSION_NODE_6 && \
	nvm install $VERSION_NODE_10 && nvm use $VERSION_NODE_10 && \
	nvm install $VERSION_NODE_8 && nvm use $VERSION_NODE_8 && \
	npm install -g sm grunt-cli bower vuepress gatsby-cli && \
	bash /usr/local/bin/yarn-install.sh --version $VERSION_YARN && \
	nvm alias default node && nvm cache clear"

## Install Ruby 2.3.x and 2.4.x
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys D39DC0E3 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
	curl -sL https://get.rvm.io | bash -s stable --with-gems="bundler"

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash --login -c "\
	rvm install $VERSION_RUBY_2_3 && rvm use $VERSION_RUBY_2_3 && gem install bundler -v 1.17.3 && gem install jekyll && \
	rvm install $VERSION_RUBY_2_4 && rvm use $VERSION_RUBY_2_4 && gem install bundler -v 1.17.3 && gem install jekyll && \
	rvm cleanup all"

## Install awscli
RUN /bin/bash -c "\
    mv /usr/bin/python /usr/bin/python2 && \
	ln -s /usr/bin/python3 /usr/bin/python && \
	pip-3.4 install awscli && rm -rf /var/cache/apk/*"

## Install Hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v${VERSION_HUGO}/hugo_${VERSION_HUGO}_Linux-64bit.tar.gz && \
    tar -xf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz hugo -C / && \
    mv /hugo /usr/bin/hugo && \
    rm -rf hugo_${VERSION_HUGO}_Linux-64bit.tar.gz

## Install AWS Amplify CLI for VERSION_NODE_DEFAULT and VERSION_NODE_10
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_DEFAULT} && \
	npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use ${VERSION_NODE_10} && \
	npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"

## Environment Setup
RUN echo export PATH="\
/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}/bin:\
/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}@global/bin:\
/usr/local/rvm/rubies/ruby-${VERSION_RUBY_DEFAULT}/bin:\
/usr/local/rvm/bin:\
/root/.yarn/bin:\
/root/.config/yarn/global/node_modules/.bin:\
/root/.nvm/versions/node/${VERSION_NODE_DEFAULT}/bin:\
$PATH" >> ~/.bashrc && \
    echo export GEM_PATH="/usr/local/rvm/gems/ruby-${VERSION_RUBY_DEFAULT}" >> ~/.bashrc && \
    echo "nvm use ${VERSION_NODE_DEFAULT} 1> /dev/null" >> ~/.bashrc

ENTRYPOINT [ "bash", "-c" ]
