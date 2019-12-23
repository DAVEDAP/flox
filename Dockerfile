FROM ubuntu:18.04
MAINTAINER dangerfish96

COPY run.sh /
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -q -q update 
# &&  apt-get -q -q -y upgrade --no-install-recommends 
RUN apt-get -q -q -y install --no-install-recommends ca-certificates git curl php wget php-curl php-mysql php-xml php-zip composer php-mbstring apt-utils
RUN git clone https://github.com/devfake/flox
RUN cd flox/backend && composer install
RUN cd flox/backend && php artisan flox:init
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get -q -q update 
RUN apt-get -q -q -y install --no-install-recommends nodejs
CMD bash run.sh
## THE LIFE SAVER
#ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
#RUN chmod +x /wait

## Launch the wait tool and then your application
#CMD /wait && npm start
