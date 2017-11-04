
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

local filename "Z:\PUBLIC_web\Stataworkshops\file_equal\README.txt"
mata:	
X=docread("`filename'")
X
end

local filename "dd_do_ex.smd"
mata:	
X=docread("`filename'")
X
end
