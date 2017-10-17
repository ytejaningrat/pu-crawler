all:
	cp html/header.html index.html
	perl perl/mojo.pl >> index.html
	cat html/footer.html >> index.html
