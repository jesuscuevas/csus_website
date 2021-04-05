serve:
	jekyll serve --watch

up:
	rm _posts/*.pdf
	jekyll build
	lftp -e "mirror -R _site .; bye" -u fitzgerald ftps://webpages.csus.edu

# Used after updating OS
update:
	bundle update

%.pdf: %.md
	pandoc -t beamer -s $< -o $@
