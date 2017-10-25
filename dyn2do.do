cd "z:/public_web/stataworkshops/dyn2do"
clear

* Need an option for max line length, here defaulting to 256

* infix str doc_line 1-256 using "altered ereturn.smd"
* infix str doc_line 1-256 using "dyndoc_ex.smd"
infix str doc_line 1-256 using "dd_display_ex.smd"
compress doc_line

* Drop <<dd_ignore>> first
generate dd_ignore = usubstr(doc_line, 1, 11) == "<<dd_ignore"
replace dd_ignore = -1 if usubstr(doc_line, 1, 12) == "<</dd_ignore"
generate ignore_block = sum(dd_ignore)
drop if ignore_block
drop dd_ignore ignore_block

* Find <<dd_display: >>

* There can be more than one "<<dd_display:" per line
generate di_cnt = (ustrlen(doc_line) - ustrlen(ustrregexra(doc_line, "<<dd_display:", "")))/ustrlen("<<dd_display:")
quietly summarize di_cnt
while (r(max)>1) {
	expand = 2 if di_cnt > 1, generate(dup)
	*replace doc_line = ustrregexrf(doc_line, "<<dd_display:.*>>", "") if dup
	generate di_trunc = ustrpos(doc_line, ">>")
	replace doc_line = usubstr(doc_line, 1, di_trunc+1) if dup == 0
	replace doc_line = usubstr(doc_line, di_trunc+2, .) if dup
	drop dup di_trunc dup
	replace di_cnt = (ustrlen(doc_line) - ustrlen(ustrregexra(doc_line, "<<dd_display:", "")))/ustrlen("<<dd_display:")
	quietly summarize di_cnt
}
generate di_pos = ustrpos(doc_line, "<<dd_display:")
generate di_end = ustrpos(doc_line, ">>") if di_pos > 0
replace doc_line = usubstr(doc_line, di_pos+13, di_end-di_pos-13) if di_pos > 0
replace doc_line = "display " + doc_line if di_pos > 0
drop di_cnt di_end

* Then extract <<dd_do>>
generate dd_do = usubstr(doc_line, 1, 7) == "<<dd_do"
replace dd_do = -1 if usubstr(doc_line, 1, 8) == "<</dd_do"
generate do_block = sum(dd_do)
keep if do_block | di_pos
replace doc_line = "" if dd_do == 1
drop di_pos dd_do do_block

* Process skips? <<dd_skip_if>>

* Process <<dd_remove>> ?

* Write out the result
compress doc_line
outfile doc_line using "example.do", noquote wide replace
