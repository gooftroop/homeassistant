FROM homeassistant/home-assistant

ENV TZ=America/New_York

EXPOSE 80
EXPOSE 443
EXPOSE 3080
EXPOSE 3443
EXPOSE 8123

RUN touch /etc/apt/sources.list.d/stretch-backports.list
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list
RUN apt-get update
RUN apt-get install -y certbot -t stretch-backports
RUN apt-get install -y augeas-lenses libaugeas0 libpython-dev libpython2.7 libpython2.7-dev python-dev python-pip-whl python-pkg-resources python-virtualenv python2.7-dev python3-virtualenv virtualenv

RUN mkdir certbot
RUN cd certbot/ && wget https://dl.eff.org/certbot-auto
RUN cd certbot/ && chmod 777 ./certbot-auto
RUN cd certbot/ && ./certbot-auto certonly --non-interactive --agree-tos --standalone --preferred-challenges http-01 --email webb.c.brandon@gmail.com -d gooftroop.servebeer.com. --http-01-port 3080 --http-01-address 0.0.0.0 --https-port 3443
RUN ls /etc/letsencrypt/live/
RUN chmod 755 /etc/letsencrypt/live/ &&  chmod 755 /etc/letsencrypt/archive/
