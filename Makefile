REMOTEUSER ?= mt287	
HOST ?= gort.sites.duke.edu
DIR ?= /understandgerrymandering
REMOTE ?= $(REMOTEUSER)@$(HOST):$(DIR)

.PHONY: clean
clean:
	rm -rf docs/*

push:
	cp favicon.ico docs/
	rsync -azv --delete  --exclude='.DS_Store'  docs/ $(REMOTE)

unbind:
	lsof -wni tcp:4000

serve:
	hugo server --watch
