mata:
string matrix function expand_display_rows(string colvector X, ///
		real colvector count) {
	string matrix Y
	Y=J(0,2,"")

	for(i=1;i<=rows(X);i++) {
		if (count[i,1] !=0) {
		for(j=1;j<=count[i];j++) {
			Y = Y\(X[i,.],strofreal(j))
			}
		}
		else {
			Y = Y\(X[i,.],"1")
			}
		}
	return(Y)
	}
end
