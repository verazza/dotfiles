# This Makefile demonstrates how to use the git submodule command

.PHONY: all submodules clean

all: submodules

submodules:
	@echo "Initializing and updating Git submodules..."
	git submodule init && git submodule update --recursive --remote
	@echo "Git submodules updated."

clean:
	@echo "Cleaning up..."
	# Add any other clean commands here if needed
	@echo "Cleanup complete."
