
FROM ubuntu:18.04

# Container utils
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive \
	apt-get -y --no-install-recommends install \
		sudo \
		iptables \
		openssh-server \
		rsync \
		\
		build-essential \
		autoconf \
		file \
		unzip \
		zip \
		openjdk-11-jdk \
		libx11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev \
		libcups2-dev \
		libfontconfig1-dev \
		libasound2-dev \
	&& apt-get clean \
	&& rm -rf /var/lib/apt /var/cache/apt

COPY create_matching_user.sh /usr/local/sbin/
COPY init.sh /usr/local/sbin/

COPY id_rsa.pub /home/user/.ssh/authorized_keys
COPY user.bashrc /home/user/.bashrc
COPY user.bash_profile /home/user/.bash_profile

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV WORKSPACE /p
EXPOSE 22
CMD ["/usr/local/sbin/init.sh"]
