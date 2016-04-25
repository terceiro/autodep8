PREFIX ?= /usr/local
install_support = $(patsubst support/%, install-%, $(wildcard support/*))

all: autodep8.1

autodep8.1: autodep8.pod
	pod2man --verbose --name autodep8 -c '' -r '' --utf8 $< $@ || ($(RM) $@; false)

autodep8.pod: README.md
	sed -e 's/^#/=head1/' $< > $@ || ($(RM) $@; false)

install: $(install_support)
	install -d $(DESTDIR)/$(PREFIX)/bin
	install -m 755 autodep8 $(DESTDIR)/$(PREFIX)/bin

$(install_support): install-%: support/%
	install -d $(DESTDIR)/$(PREFIX)/share/autodep8/$<
	install -m 755 $^/* $(DESTDIR)/$(PREFIX)/share/autodep8/$<
	install -d $(DESTDIR)/$(PREFIX)/share/man/man1
	install -m 644 autodep8.1 $(DESTDIR)/$(PREFIX)/share/man/man1

.PHONY: test
test:
	./test/run.sh test/*_test.sh

check: test

clean:
	$(RM) autodep8.pod autodep8.1
