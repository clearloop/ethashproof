build:
	rm -rf target
	@go build -o ./target/epoch -v github.com/darwinia-network/ethashproof/cmd/epoch
	@go build -o ./target/relayer -v github.com/darwinia-network/ethashproof/cmd/relayer
	@go build -o ./target/cache -v github.com/darwinia-network/ethashproof/cmd/cache
build-all: deps
	rm -rf ./target/all
	mkdir -p ./target/all && cd ./target/all
	xgo --targets=linux,darwin/amd64 github.com/darwinia-network/ethashproof/cmd/cache
	xgo --targets=linux,darwin/amd64 github.com/darwinia-network/ethashproof/cmd/epoch
	xgo --targets=linux,darwin/amd64 github.com/darwinia-network/ethashproof/cmd/relayer
deps:
	@docker pull karalabe/xgo-latest
	@go get github.com/karalabe/xgo
tar:
	rm -rf ./target/tars
	tar -czvf ./target/tars/ethashproof-darwin.tar.gz ./target/*darwin*
	tar -czvf ./target/tars/ethashproof-darwin.tar.gz ./target/*linux-amd64*
all: build-all tar
