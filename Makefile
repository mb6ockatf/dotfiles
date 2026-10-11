# Makefile - install and check the dotfiles with GNU stow
#
#   make install     link everything into $(TARGET) and enable the git hooks
#   make uninstall   remove the links
#   make dry-run     show what install would do
#   make check       syntax-check the shell files and scan for personal data
#   make lint        run shellcheck (needs shellcheck installed)

TARGET ?= $(HOME)
STOW = stow --target=$(TARGET)
SHELLCHECK ?= shellcheck
BASH_FILES = .bashrc .bash_aliases .bash_profile .config/functions.sh
SH_FILES = .profile .xprofile .xinitrc .xsessionrc .githooks/pre-commit \
	.local/bin/* .config/bspwm/bspwmrc .config/bspwm/autostart.sh \
	.config/polybar/launch.sh .config/rofi/powermenu.sh \
	.config/install_hosts.sh .config/bcalc.sh

.PHONY: all install uninstall dry-run check lint hooks

all: check

install: dry-run hooks
	$(STOW) --restow .

uninstall:
	$(STOW) --delete .

dry-run:
	@output=$$($(STOW) --no --verbose --restow . 2>&1); status=$$?; \
	printf '%s\n' "$$output" | grep -v -e '^UNLINK' -e 'reverts previous' -e 'simulation mode' -e '^$$'; \
	exit $$status

hooks:
	git config core.hooksPath .githooks

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
