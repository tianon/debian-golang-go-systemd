FROM tianon/debian-devel

# TODO remove this temporary patch once golang-dbus-dev is in the archive
RUN git clone https://github.com/tianon/debian-golang-dbus-dev.git /usr/src/golang-dbus-dev \
	&& cd /usr/src/golang-dbus-dev \
	&& apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control \
	&& uscan --force-download --verbose --download-current-version \
	&& origtargz --unpack && debuild -uc -us \
	&& dpkg -i ../golang-dbus-dev_*.deb

# start by adding just "debian/control" so we can get mk-build-deps with maximum caching
ADD control /usr/src/golang-go-systemd-dev/debian/
WORKDIR /usr/src/golang-go-systemd-dev

# get all the build deps of _this_ package in a nice repeatable way
RUN apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control

# need our debian/ directory to compile _this_ package
ADD . /usr/src/golang-go-systemd-dev/debian

# go download and unpack our upstream source
RUN uscan --force-download --verbose --download-current-version
RUN origtargz --unpack

# tianon is _really_ lazy, and likes a preseeded bash history
RUN echo 'origtargz --unpack && debuild -us -uc --lintian-opts "-EvIL+pedantic"' >> "$HOME/.bash_history"

CMD [ "debuild", "-us", "-uc", "--lintian-opts", "-EvIL+pedantic" ]
