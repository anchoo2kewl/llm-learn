# llm-learn: Audio Courses on this Mac.
#   make install   build, (re)write the launchd agent, restart it
#   make restart   restart the running service
#   make logs      follow the log
#   make bump      pin the latest pushed go-learn
SHELL   := /bin/bash
OWNER   ?= $(shell tailscale status --json | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d["User"][str(d["Self"]["UserID"])]["LoginName"])')
TSIP    ?= $(shell tailscale ip -4 | head -1)
SIDECAR ?= $(HOME)/play/go-learn/sidecar
PLIST   := $(HOME)/Library/LaunchAgents/com.llm-learn.server.plist
UID_    := $(shell id -u)

build:
	go build -o $(HOME)/.local/bin/llm-learn .

install: build
	mkdir -p $(HOME)/.local/share/llm-learn $(HOME)/.local/state/llm-learn
	sed -e 's#@HOME@#$(HOME)#g' -e 's#@OWNER@#$(OWNER)#g' -e 's#@TSIP@#$(TSIP)#g' -e 's#@SIDECAR@#$(SIDECAR)#g' deploy/com.llm-learn.server.plist.tmpl > $(PLIST)
	-launchctl bootout gui/$(UID_)/com.llm-learn.server 2>/dev/null; sleep 1
	launchctl bootstrap gui/$(UID_) $(PLIST)

restart: build
	launchctl kickstart -k gui/$(UID_)/com.llm-learn.server

logs:
	tail -f $(HOME)/.local/state/llm-learn/llm-learn.log

bump:
	GOWORK=off GOPROXY=direct go get github.com/anchoo2kewl/go-learn@main && GOWORK=off go mod tidy

.PHONY: build install restart logs bump
