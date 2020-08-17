serve:
	jekyll serve --watch

up:
	jekyll build
	lftp -e "mirror -R _site .; bye" -u fitzgerald ftps://webpages.csus.edu
