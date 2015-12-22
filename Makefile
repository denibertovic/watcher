.PHONY = build static-build release clean

VERSION=0.1.0.0
ARCH=$(shell uname -m)

build:
	@stack build
	@echo "\nBinary available at:\n"
	@echo "`pwd`/.stack-work/install/${ARCH}-linux/lts-3.16/7.10.2/bin/watcher-exe"


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

