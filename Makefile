# Makefile - install and check the dotfiles with GNU stow
#
#   make install     link everything into $(TARGET) and enable the git hooks
#   make uninstall   remove the links
#   make dry-run     show what install would do
#   make check       syntax-check the shell files and scan for personal data
#   make lint        run shellcheck (needs shellcheck installed)
#   make man         regenerate the manual pages from man/*.m4 (needs m4)

TARGET ?= $(HOME)
STOW = stow --target=$(TARGET)
SHELLCHECK ?= shellcheck
M4 ?= m4
MAN_PAGES = .local/share/man/man7/readlinebinds.7 .local/share/man/man7/kitty-guide.7 \
	.local/share/man/man7/blesh-guide.7 .local/share/man/man7/fzf-guide.7
BASH_FILES = .bashrc .bash_aliases .bash_profile .config/functions.sh
SH_FILES = .profile .xprofile .xinitrc .xsessionrc .githooks/pre-commit \
	.local/bin/* .config/bspwm/bspwmrc .config/bspwm/autostart.sh \
	.config/polybar/launch.sh .config/rofi/powermenu.sh \
	.config/install_hosts.sh .config/bcalc.sh

.PHONY: all install uninstall dry-run check lint hooks man

all: check

install: man dry-run hooks
	$(STOW) --restow .

uninstall:
	$(STOW) --delete .

dry-run:
	@output=$$($(STOW) --no --verbose --restow . 2>&1); status=$$?; \
	printf '%s\n' "$$output" | grep -v -e '^UNLINK' -e 'reverts previous' -e 'simulation mode' -e '^$$'; \
	exit $$status

hooks:
	git config core.hooksPath .githooks

man: $(MAN_PAGES)

.local/share/man/man7/%.7: man/%.7.m4
	$(M4) -P $< > $@.tmp && mv $@.tmp $@

check:
	bash -n .bashrc .bash_aliases .bash_profile .config/functions.sh
	dash -n .profile .xprofile .xinitrc .xsessionrc .githooks/pre-commit
	for script in .local/bin/*; do \
		head -n 1 "$$script" | grep -q bash && bash -n "$$script" || dash -n "$$script" || exit 1; \
	done
	.githooks/pre-commit --all

lint:
	$(SHELLCHECK) --severity=warning $(SH_FILES)
	$(SHELLCHECK) --severity=warning --shell=bash $(BASH_FILES)
