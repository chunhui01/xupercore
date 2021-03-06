# init project PATH
HOMEDIR := $(shell pwd)
OUTDIR  := $(HOMEDIR)/output
COMPILECACHEDIR := $(HOMEDIR)/.compile_cache
XVMDIR  := $(COMPILECACHEDIR)/xvm
TESTNETDIR := $(HOMEDIR)/testnet

# init command params
export GO111MODULE=on
X_ROOT_PATH := $(HOMEDIR)
export X_ROOT_PATH
export PATH := $(OUTDIR)/bin:$(XVMDIR):$(PATH)

# make, make all
all: clean compile

# make compile, go build
compile: xvm xchain
# make xchain
xchain:
	bash $(HOMEDIR)/example/xchain/auto/build.sh
# make xvm
xvm:
	bash $(HOMEDIR)/example/xchain/auto/build_xvm.sh

# make test, test your code
test: xvm unit
unit:
	go test -coverprofile=coverage.txt -covermode=atomic ./...

# make clean
cleanall: clean cleantest cleancache
clean:
	rm -rf $(OUTDIR)
cleantest:
	rm -rf $(TESTNETDIR)
cleancache:
	rm -rf $(COMPILECACHEDIR)

# deploy test network
testnet:
	bash $(HOMEDIR)/example/xchain/auto/deploy_testnet.sh

# avoid filename conflict and speed up build
.PHONY: all compile test clean
