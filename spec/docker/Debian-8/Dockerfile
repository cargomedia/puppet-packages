FROM cargomedia/base:v1

# stdlibs
RUN puppet module install puppetlabs/stdlib

# polipo
ADD conf/polipo.conf /etc/polipo/config
RUN apt-get -qyo Dpkg::Options::='--force-confold' install polipo
