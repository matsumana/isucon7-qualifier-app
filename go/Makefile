GOPATH := ${PWD}
export GOPATH

build:
	bash ./build.sh

upload:
	./awstool s3upload --object isubata --user sgykfjsm

vet:
	go vet ./src/isubata/...

sync:
	git fetch origin master
	git pull origin master

clean:
	$(RM) -rv ./isubata
