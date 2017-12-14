*! version 1.0
* Doug Hemken
* 26 October 2017

capture program drop dyn2do
program define dyn2do, rclass
	syntax using/, [LINElength(integer 256)] [SAVing(string)]
	preserve
	if ("`saving'" == "" ) {
		di "  {text:No output file specified.}"
		_replaceext using "`using'", new("do")
		local saving "`r(newfile)'"
		}
	clear
	
* Read in file
	quietly infix str doc_line 1-`linelength' using "`using'"
	quietly compress doc_line

* Drop <<dd_ignore>> first
	quietly generate dd_ignore = usubstr(doc_line, 1, 11) == "<<dd_ignore"
	quietly replace dd_ignore = -1 if usubstr(doc_line, 1, 12) == "<</dd_ignore"
	quietly generate ignore_block = sum(dd_ignore)
	quietly drop if ignore_block
	*drop dd_ignore ignore_block

* Find <<dd_display: >>

* There can be more than one "<<dd_display:" per line
	quietly generate di_cnt = (ustrlen(doc_line) - ustrlen(ustrregexra(doc_line, "<<dd_display:", "")))/ustrlen("<<dd_display:")
	quietly summarize di_cnt
	quietly while (r(max)>1) {
		expand = 2 if di_cnt > 1, generate(dup)
		generate di_trunc = ustrpos(doc_line, ">>")
		replace doc_line = usubstr(doc_line, 1, di_trunc+1) if dup == 0
		replace doc_line = usubstr(doc_line, di_trunc+2, .) if dup
		drop dup di_trunc dup
		replace di_cnt = (ustrlen(doc_line) - ustrlen(ustrregexra(doc_line, "<<dd_display:", "")))/ustrlen("<<dd_display:")
		quietly summarize di_cnt
	}
	quietly generate di_pos = ustrpos(doc_line, "<<dd_display:")
	quietly generate di_end = ustrpos(doc_line, ">>") if di_pos > 0
	quietly replace doc_line = usubstr(doc_line, di_pos+13, di_end-di_pos-13) if di_pos > 0
	quietly replace doc_line = "display " + doc_line if di_pos > 0
	*drop di_cnt di_end

* Then extract <<dd_do>>
	quietly generate dd_do = usubstr(doc_line, 1, 7) == "<<dd_do"
	quietly replace dd_do = -1 if usubstr(doc_line, 1, 8) == "<</dd_do"
	quietly generate do_block = sum(dd_do)
	quietly keep if do_block | di_pos
	quietly replace doc_line = "" if dd_do == 1
	*drop di_pos dd_do do_block

* Process skips? <<dd_skip_if>>

* Process <<dd_remove>> ?

* Write out the result
	quietly compress doc_line
	outfile doc_line using "`saving'", noquote wide replace
	display "  {text:Output saved as {it:`saving'}}"

* Finish up
	restore
	return local outfile "`saving'"
end


