FROM tianon/debian-devel

# TODO remove this temporary patch once golang-dbus is in the archive
RUN git clone git://anonscm.debian.org/pkg-go/packages/golang-dbus.git /usr/src/golang-dbus \
	&& cd /usr/src/golang-dbus \
	&& apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control \
	&& uscan --force-download --verbose --download-current-version \
	&& origtargz --unpack && debuild -uc -us \
	&& dpkg -i ../golang-dbus-dev_*.deb

# start by adding just "debian/control" so we can get mk-build-deps with maximum caching
ADD control /usr/src/golang-go-systemd/debian/
WORKDIR /usr/src/golang-go-systemd

# get all the build deps of _this_ package in a nice repeatable way
RUN apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control

# need our debian/ directory to compile _this_ package
ADD . /usr/src/golang-go-systemd/debian

# go download and unpack our upstream source
RUN uscan --force-download --verbose --download-current-version
RUN origtargz --unpack

# tianon is _really_ lazy, and likes a preseeded bash history
RUN echo 'origtargz --unpack && debuild -us -uc --lintian-opts "-EvIL+pedantic"' >> "$HOME/.bash_history"

CMD [ "debuild", "-us", "-uc", "--lintian-opts", "-EvIL+pedantic" ]
