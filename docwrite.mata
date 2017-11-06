mata:
void function docwrite(string scalar filename, ///
		string colvector document) {
	fh = fopen(filename, "w")
	for (i=1; i<=length(document); i++) {
		fput(fh, document[i])
	}
	fclose(fh)
	}
end

