FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive

# Install tools
RUN apt-get update
RUN apt-get install -y wget git procps

# Install and configure JDK
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
RUN mkdir /usr/java && cd /usr/java && tar x -C /usr/java -f /jdk-8u151-linux-x64.tar.gz && rm /jdk-8u151-linux-x64.tar.gz
RUN update-alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_151/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_151/bin/javac 100

ENV JAVA_HOME /usr/java/jdk1.8.0_151
ENV PATH ${JAVA_HOME}/bin:${PATH}

## Test 
RUN java -version

RUN rm -fr /var/lib/apt/lists/*

# Create working directory
RUN mkdir -p /local/git
WORKDIR /local/git
CMD [ "/bin/bash", "-l"]