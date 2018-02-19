FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive

# Install tools
RUN apt-get update && apt-get install -y wget procps

# Install and configure JDK
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
RUN mkdir /usr/java && cd /usr/java && tar x -C /usr/java -f /jdk-8u161-linux-x64.tar.gz && rm /jdk-8u161-linux-x64.tar.gz
RUN update-alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_161/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_161/bin/javac 100

ENV JAVA_HOME /usr/java/jdk1.8.0_161
ENV PATH ${JAVA_HOME}/bin:${PATH}
RUN ln -s $JAVA_HOME /usr/java/latest 

# Test 
RUN java -version

# Remove tools
RUN apt-get -y --purge autoremove wget

RUN rm -fr /var/lib/apt/lists/*

# Working directory
WORKDIR /tmp/
CMD [ "/bin/bash", "-l"]