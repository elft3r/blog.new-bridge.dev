watch:
	docker run --rm -it --volume="${PWD}":/srv/jekyll -p 35729:35729 -p 4000:4000 jekyll/jekyll jekyll serve --drafts --future -l watch
