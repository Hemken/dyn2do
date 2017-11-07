mata:
void function dyn2do (string scalar filename1, string scalar filename2) {
	X=docread(filename1)
	di_cnt = (ustrlen(X) :- ustrlen(ustrregexra(X, "<<dd_display:", ""))):/ustrlen("<<dd_display:")
	X=expand_display_rows(X,di_cnt)
	line_rep = strtoreal(X[.,2])
	X=X[.,1]
	do_blocks = mark_text_blocks(X, "<<dd_do", "<</dd_do>>", 0)
	ignore_blocks = mark_text_blocks(X, "<<dd_ignore", "<</dd_ignore>>", 0)
	display_lines = ustrpos(X,"<<dd_display:") :> 0
	D = select(X, display_lines)
	D_rep = select(line_rep, display_lines)
	for (i=1;i<=rows(D);i++) {
		if (D_rep[i] > 1) {
			D[i] = usubinstr(D[i], usubstr(D[i], 1, ustrpos(D[i], "<<dd_display:"):+12), "", D_rep[i]-1)
			}
		}
	D = usubinstr(D, usubstr(D, 1, ustrpos(D, "<<dd_display:"):+12), "display ", 1)
	D = usubinstr(D, usubstr(D, ustrpos(D, ">>"), .), "", 1)
	X[selectindex(display_lines)] = D
	unlink(filename2)
	docwrite(filename2, select(X, (do_blocks :| display_lines) :& !ignore_blocks))
}
end
