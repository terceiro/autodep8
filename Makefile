PREFIX ?= /usr/local
install_support = $(patsubst support/%, install-%, $(wildcard support/*))

all:
	@echo Built

install: $(install_support)
	install -d $(DESTDIR)/$(PREFIX)/bin
	install -m 755 autodep8 $(DESTDIR)/$(PREFIX)/bin

$(install_support): install-%: support/%
	install -d $(DESTDIR)/$(PREFIX)/share/autodep8/$<
	install -m 755 $^/* $(DESTDIR)/$(PREFIX)/share/autodep8/$<

.PHONY: test
test:
	./test/run.sh test/*_test.sh

check: test

clean:
	@echo Clean
