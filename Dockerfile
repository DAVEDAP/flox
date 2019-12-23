FROM ubuntu:18.04
MAINTAINER dangerfish96

ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -q -q update 
# &&  apt-get -q -q -y upgrade --no-install-recommends 
RUN apt-get -q -q -y install --no-install-recommends ca-certificates git php wget php-curl php-mysql php-xml php-zip composer php-mbstring
RUN git clone https://github.com/devfake/flox
RUN cd flox/backend && composer install
RUN cd flox/backend && php artisan flox:init
RUN sed -i 's/TMDB_API_KEY=/TMDB_API_KEY=/g' flox/backend/.env
RUN sed -i 's/DB_PORT=.*$/DB_PORT=3306/g' flox/backend/.env
RUN sed -i 's/DB_HOST=.*/DB_HOST=db/g' flox/backend/.env
RUN sed -i 's/DB_DATABASE=/DB_DATABASE=flox/g' flox/backend/.env
RUN sed -i 's/DB_USERNAME=/DB_USERNAME=root/g' flox/backend/.env
RUN sed -i 's/DB_PASSWORD=/DB_PASSWORD=password/g' flox/backend/.env

RUN sed -i 's/MAIL_USERNAME=/MAIL_USERNAME=user/g' flox/backend/.env
RUN sed -i 's/MAIL_PASSWORD=/MAIL_PASSWORD=user/g' flox/backend/.env
CMD cd flox/backend && cat .env && php artisan flox:db
## THE LIFE SAVER
#ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait
#RUN chmod +x /wait

## Launch the wait tool and then your application
#CMD /wait && npm start
