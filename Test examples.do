cd "Z:/PUBLIC_Web/Stataworkshops/dyn2do"
run "dyn2do.ado
cscript dyn2do adofiles dyn2do.ado
run "dyn2do.ado

cd "Z:/PUBLIC_Web/Stataworkshops/dyn2do/Examples"

* Example 1: dd_do_ex - <<dd_do>> and <<dd_ignore>>
dyndoc "dd_do_ex.smd", saving("dd_do_ex.html") replace
file_equal "dd_do_ex.html" using "dd_do_ex.html_bm"
assert r(equal) == 1

dyntext "dd_do_ex.smd", saving("dd_do_ex.md") replace
file_equal "dd_do_ex.md" using "dd_do_ex.md_bm"
assert r(equal) == 1

capture dyn2do "dd_do_ex.smd"
assert _rc != 0  // needs "replace" option

dyn2do "dd_do_ex.smd", replace
file_equal "`r(outfile)'" using "dd_do_ex.do_bm"
assert r(equal) == 1

capture dyn2do "dd_do_ex.smd", saving("dd_do_ex.do")
assert _rc != 0 // needs "replace" option

dyn2do "dd_do_ex.smd", saving("dd_do_ex.do") replace
file_equal "`r(outfile)'" using "dd_do_ex.do_bm"
assert r(equal) == 1

* Example 2 - two <<dd_display>> tags on one line
dyn2do "dd_display_ex.smd", replace
file_equal "`r(outfile)'" using "dd_display_ex.do_bm"
assert r(equal) == 1

* Example 3 - Stata's main example
dyn2do "http://www.stata-press.com/data/r15/markdown/dyndoc_ex.txt", saving(dyndoc_ex.do)
file_equal "`r(outfile)'" using "dyndoc_ex.do_bm"
assert r(equal) == 1

* Example 4
dyn2do "altered ereturn.smd"

* Example 5
dyndoc "dd_do_ex_3backticks.smd", saving("dd_do_ex_3backticks.html") replace
dyntext "dd_do_ex_3backticks.smd", saving("dd_do_ex_3backticks.md") replace
