.PHONY: run deploy submod

all: deploy subup
	git add -A;git commit -m fix;git push

init:
	brew install hugo

run:
	hugo server

clean:
	rm -rf public resources
	ls -la

deploy:
	hugo
	git add -A && git commit -m "rebuilding site `date`" && git push origin master

up:
	git fetch --prune
	git reset --hard origin/master
	git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -D %

sync:
	cd themes/gohugo-theme-ananke && git fetch upstream && git merge upstream/master && git push

subup:
	git submodule foreach git pull origin master

subinit:
	git submodule add --force -b master https://github.com/sasaendou/gohugo-theme-ananke themes/gohugo-theme-ananke
	cd themes/gohugo-theme-ananke && git remote add upstream https://github.com/budparr/gohugo-theme-ananke

subrm:
	git submodule deinit -f --all
	rm .git/modules/*
	rm .gitmodules
	git rm -rf themes
	git rm -rf public
