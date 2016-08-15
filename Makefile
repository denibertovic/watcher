.PHONY = build static-build release clean

PROJECT_NAME ?= $(shell grep "^name" watcher.cabal | cut -d " " -f17)
VERSION ?= $(shell grep "^version:" watcher.cabal | cut -d " " -f14)
RESOLVER ?= $(shell grep "^resolver:" stack.yaml | cut -d " " -f2)
GHC_VERSION ?= $(shell stack ghc -- --version | cut -d " " -f8)
ARCH=$(shell uname -m)

BINARY_PATH = `pwd`/.stack-work/install/${ARCH}-linux/${RESOLVER}/${GHC_VERSION}/bin/${PROJECT_NAME}-exe

build:
	@stack build
	@echo "\nBinary available at:\n"
	@echo ${BINARY_PATH}


static-build: clean
	@mkdir -p release/build
	@stack ghc -- \
	app/Main.hs \
	src/Lib.hs \
	-static \
	-rtsopts=all \
	-optl-pthread \
	-optl-static \
	-O2 \
	-threaded \
	-odir release/build \
	-hidir release/build \
	-o release/watcher-${VERSION}-linux-${ARCH}

clean:
	@rm -rf release

release: static-build
	@echo "\n\nRelease available at:\n"
	@echo "STATIC BINARY: `pwd`/release/watcher-${VERSION}-linux-${ARCH}\n"

