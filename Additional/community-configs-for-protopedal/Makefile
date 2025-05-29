all: scripts rules services

scripts:
	src/create-scripts.sh

rules:
	src/create-udev-rules.sh $(group)

services:
	src/create-services.sh

install:
	mkdir -p $(prefix)/usr/bin/
	mkdir -p $(prefix)/etc/udev/rules.d/
	mkdir -p $(prefix)/etc/systemd/system/
	cp output/scripts/*  $(prefix)/usr/bin/
	cp output/rules/*    $(prefix)/etc/udev/rules.d/
	cp output/services/* $(prefix)/etc/systemd/system/

uninstall:
	rm $(prefix)/usr/bin/protopedal-*.sh
	rm $(prefix)/etc/udev/rules.d/99-protopedal-*.rules
	rm $(prefix)/etc/systemd/system/protopedal-*.service

clean:
	rm -rf output
