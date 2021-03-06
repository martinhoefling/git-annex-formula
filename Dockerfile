FROM      martinhoefling/salt-minion:debian
MAINTAINER Martin Hoefling <martin.hoefling@gmx.de>

# push formula
ADD git-annex /srv/salt/git-annex
ADD pillar.example /srv/pillar/example.sls
RUN echo "file_client: local" > /etc/salt/minion.d/local.conf
RUN echo "base:" > /srv/pillar/top.sls
RUN echo "  '*':" >> /srv/pillar/top.sls
RUN echo "    - example" >> /srv/pillar/top.sls
RUN apt-get install -y haskell-platform libgnutls-dev libgsasl7-dev zlib1g-dev libxml2-dev
RUN salt-call --local state.sls git-annex | tee log.txt && grep "Failed:    0" log.txt