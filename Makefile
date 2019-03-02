.PHONY: run deploy submod

all: deploy subup
	git add -A;git commit -m fix;git push

init:
	brew install hugo

run:
	hugo server

deploy:
	hugo
	cd public && git add . && git commit -m "rebuilding site `date`" && git push origin master

subup:
	git submodule foreach git pull origin master

subinit:
	git submodule add --force -b master https://github.com/sasaendou/gohugo-theme-ananke themes/gohugo-theme-ananke

subrm:
	git submodule deinit -f --all
	rm .git/modules/*
	rm .gitmodules
	git rm -rf themes
	git rm -rf public
