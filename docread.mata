mata:
string colvector docread(string scalar filename) {
	fh = fopen(filename, "r")
	string colvector document
	document= J(0,1,"")
	while ((line=fget(fh))!=J(0,0,"")) {
		document = (document\line)
	}
	fclose(fh)
	return(document)
	}
end

