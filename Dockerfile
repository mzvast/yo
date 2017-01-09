FROM centos:7

RUN yum install -y which git gcc-c++ make curl wget bzip2
# Install Java
RUN wget --no-cookies --no-check-certificate --header \
 "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
 "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm"

RUN yum localinstall -y jdk-*-linux-x64.rpm
RUN rm ./jdk-*-linux-x64.rpm

# Install Node
RUN   \
  wget -O - https://nodejs.org/dist/v6.9.4/node-v6.9.4-linux-x64.tar.gz \
  | tar xzf - --strip-components=1 --exclude="README.md" --exclude="LICENSE" \
  --exclude="ChangeLog" -C "/usr/local"

VOLUME ["/src"]

RUN useradd -ms /bin/bash node
RUN chown -R node:node /src /opt /usr
ENV HOME /home/node

USER node

WORKDIR   /src

RUN npm i -g  yo bower grunt-cli gulp

CMD /bin/bash

