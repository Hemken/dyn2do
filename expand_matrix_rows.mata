mata:
transmorphic matrix function expand_matrix_rows(transmorphic matrix X, ///
		real colvector count) {
	transmorphic matrix Y
	if (isstring(X)) {
		printf("%s\n", "string test")
		Y=J(0,1,"")
		}
	else if (isreal(X)) {
		Y=J(0,1,.)
		}
	for(i=1;i<=rows(X);i++) {
		if (count[i,1] !=0) {
		for(j=1;j<=count[i];j++) {
			Y = Y\X[i,.]	
			}
		}
		else {
		//printf("%s\n", "count = zero")
			//Y
			//X[i,.]
			Y = Y\X[i,.]
			}
		}
	return(Y)
	}
end
