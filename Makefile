PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
SCRIPT = bin/aur-lite

.PHONY: all install uninstall clean check help

all: help

help:
	@echo "aur-lite Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  install    - Install aur-lite to $(BINDIR)"
	@echo "  uninstall  - Remove aur-lite from $(BINDIR)"
	@echo "  check      - Run shellcheck on the script"
	@echo "  clean      - Clean the default cache directory"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Variables:"
	@echo "  PREFIX=$(PREFIX) (installation prefix)"
	@echo ""
	@echo "Example:"
	@echo "  sudo make install"
	@echo "  make install PREFIX=~/.local"

install:
	@echo "Installing aur-lite to $(BINDIR)"
	@install -Dm755 $(SCRIPT) $(BINDIR)/aur-lite
	@echo "Installation complete"

uninstall:
	@echo "Removing aur-lite from $(BINDIR)"
	@rm -f $(BINDIR)/aur-lite
	@echo "Uninstallation complete"

check:
	@if command -v shellcheck >/dev/null 2>&1; then \
		echo "Running shellcheck..."; \
		shellcheck $(SCRIPT); \
		echo "Check complete"; \
	else \
		echo "shellcheck not found, skipping check"; \
		echo "Install shellcheck to enable script validation"; \
	fi

clean:
	@echo "Cleaning default cache directory..."
	@rm -rf ~/.cache/aur-mirror
	@echo "Cache cleaned"