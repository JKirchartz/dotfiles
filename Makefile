# Makefile for Git submodule management
# https://www.w3tutorials.net/blog/automatic-initialization-and-update-of-submodules-in-makefile/
# Usage:
#   make submodules        # Initialize and update all submodules (recursive)
#   make submodules-sync   # Sync submodule URLs (run if .gitmodules changes)
#   make submodules-force-update  # Pull latest from submodule branches (main)
#   make submodules-clean  # Discard local changes in submodules

# Check if .gitmodules exists before running submodule commands
SUBMODULES_EXIST := $(wildcard .gitmodules)

# Default target: Initialize and update submodules
submodules:
@if [ -z "$(SUBMODULES_EXIST)" ]; then \
    echo "No .gitmodules found; skipping submodules."; \
    exit 0; \
    fi
    $(MAKE) submodules-init submodules-update

# Initialize submodules (copy .gitmodules to .git/config)
    submodules-init:
    @echo "Initializing submodules..."
    git submodule init

# Update submodules to parent repo's specified commits (recursive)
    submodules-update:
    @echo "Updating submodules (recursive)..."
    @set -e; \
      git submodule update --recursive

# Sync submodule URLs and re-initialize
      submodules-sync:
      @if [ -z "$(SUBMODULES_EXIST)" ]; then \
        echo "No .gitmodules found; skipping sync."; \
        exit 0; \
        fi
        @echo "Syncing submodule URLs (recursive)..."
        git submodule sync --recursive
        $(MAKE) submodules-init

# Force-update submodules to latest commits on their 'main' branch
        submodules-force-update:
        @if [ -z "$(SUBMODULES_EXIST)" ]; then \
          echo "No .gitmodules found; skipping force update."; \
          exit 0; \
          fi
          @echo "Forcing submodules to latest 'main' branch commits..."
          git submodule foreach --recursive 'git checkout main && git pull origin main'

# Clean submodules (discard local changes)
          submodules-clean:
          @if [ -z "$(SUBMODULES_EXIST)" ]; then \
            echo "No .gitmodules found; skipping clean."; \
            exit 0; \
            fi
            @echo "Cleaning submodule changes..."
            git submodule foreach --recursive 'git reset --hard && git clean -fd'

# https://github.com/staticshock/dotfiles/blob/87d04bf68039fb52485e2c83e3fbe8eacc2683d6/Makefile#L48C1-L70C29
define mkdir_and_export_target
  @mkdir -p "$$(dirname "$@")"
  $(export_target)
endef

ifeq ($(RSYNC),y)
  export_target = @[[ -d "$<" ]] && sl='/' || sl=''; rsync -ai --del "$<$$sl" "$@"
  else
ifeq ($(COPY),y)
  export_target = @cp -rfv "$<" "$@"
  else
# Use '-T' option of GNU coreutils `ln` if available to prevent interpreting
# the target argument of `ln` as a directory into which to link a regular
# file (i.e., `ln -s FILE FILE` and `ln -s DIR DIR` are allowed, but
# `ln -s FILE DIR` is not). GNU `ln` might be installed as `gln` under
# non-Linux systems.
  export_target = @if ln --version 2>/dev/null | grep -qe'GNU coreutils'; then \
  ln -sfTv "$<" "$@"; \
  elif gln --version 2>/dev/null | grep -qe'GNU coreutils'; then \
  gln -sfTv "$<" "$@"; \
  elif [ -f "$<" ] && [ -d "$@" ]; then \
  echo "$@ must be a regular file if $< is" 1>&2; \
  else ln -sfv "$<" "$@"; fi
endif
endif

# Mark all submodule targets as phony (not files)
.PHONY: submodules submodules-init submodules-update submodules-sync submodules-force-update submodules-clean 
