FROM homeassistant/home-assistant

ENV TZ=America/New_York

EXPOSE 8123

RUN touch /etc/apt/sources.list.d/stretch-backports.list
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list
RUN apt-get update
RUN apt-get install -y certbot -t stretch-backports
RUN mkdir certbot
RUN cd certbot/ && wget https://dl.eff.org/certbot-auto
RUN cd certbot/ && /certbot-auto certonly --standalone --preferred-challenges http-01 --email webb.c.brandon@gmail.com -d gooftroop.servebeer.com
RUN ls /etc/letsencrypt/live/
RUN chmod 755 /etc/letsencrypt/live/ &&  chmod 755 /etc/letsencrypt/archive/
