.PHONY: all publish publish_no_init

EMACS =
PORT = 9091 

ifndef EMACS
EMACS = "emacs"
endif

all: publish

publish: publish.el
	@echo "Publishing..."
	${EMACS} --batch --no-init --load publish.el --funcall org-publish-all

serve: publish
	@python -m http.server --directory=public/ ${PORT}

clean:
	@echo "Cleaning up..."
	@rm -rvf *.elc
	@rm -rvf public
	@rm -rvf ~/.org-timestamps/*
