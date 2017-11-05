mata:
string colvector docread(string scalar filename) {
	fh = fopen(filename, "r")
	string colvector doc
	doc= J(0,1,"")
	while ((line=fget(fh))!=J(0,0,"")) {
		doc = (doc\line)
	}
	fclose(fh)
	return(doc)
	}
end

