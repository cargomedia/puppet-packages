FROM cargomedia/base:v1

# stdlibs
RUN puppet module install puppetlabs/stdlib

# polipo
ADD conf/polipo.conf /etc/polipo/config
RUN apt-get -qyo Dpkg::Options::='--force-confold' install polipo

# set polipo proxy
ADD conf/proxy-apt.conf /etc/apt/apt.conf.d/01proxy
ADD conf/proxy-env.sh /etc/profile.d/proxy.sh
