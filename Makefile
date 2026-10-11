# Makefile - install and check the dotfiles with GNU stow
#
#   make install     link everything into $(TARGET) and enable the git hooks
#   make uninstall   remove the links
#   make dry-run     show what install would do
#   make check       syntax-check the shell files and scan for personal data

TARGET ?= $(HOME)
STOW = stow --target=$(TARGET)

.PHONY: all install uninstall dry-run check hooks

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
	dash -n .profile .xprofile .xinitrc .githooks/pre-commit
	for script in .local/bin/*; do \
		head -n 1 "$$script" | grep -q bash && bash -n "$$script" || dash -n "$$script" || exit 1; \
	done
	.githooks/pre-commit --all
