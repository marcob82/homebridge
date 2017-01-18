FROM nodesource/xenial
MAINTAINER marcob82

##################################################
# Set environment variables                      #
##################################################

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

##################################################
# Install tools                                  #
##################################################

RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    apt-transport-https \
    locales \
    curl \
    wget \
    git \
    python \
    build-essential \
    make \
    g++ \
    libavahi-compat-libdnssd-dev \
    libkrb5-dev \
    vim \
    net-tools 

##################################################
# Install homebridge                             #
##################################################

RUN npm install -g homebridge \
     homebridge-fhem
#    homebridge-philipshue \
#    homebridge-ninjablock-temperature \
#    homebridge-ninjablock-humidity \
#    homebridge-ninjablock-alarmstatedevice \
#    homebridge-luxtronik2 \
#    homebridge-people \
#    homebridge-mqttswitch \
#    homebridge-edomoticz \
#    homebridge-philipshue \
#    homebridge-liftmaster \
#    homebridge-ifttt \
#    homebridge-nest \
#    homebridge-wink --unsafe-perm

# Copy Startscript
ADD run.sh /root/run.sh
RUN ["chmod", "+x", "/root/run.sh"]


##################################################
# Start                                          #
##################################################

USER root
RUN mkdir -p /var/run/dbus

#ADD run.sh /root/run.sh
EXPOSE 5353 51826
VOLUME ["/root/.homebridge"]

CMD ["/root/run.sh"]
