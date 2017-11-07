cd "Z:/PUBLIC_Web/Stataworkshops/dyn2do"
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

dyn2do using "dd_do_ex.smd"
file_equal "`r(outfile)'" using "dd_do_ex.html_bm"
assert r(equal) == 1

* Example 2
dyn2do using "dd_display_ex.smd"
* Example 3
dyn2do using "dyndoc_ex.smd"
* Example 4
dyn2do using "altered ereturn.smd"

* Example 5
dyndoc "dd_do_ex_3backticks.smd", saving("dd_do_ex_3backticks.html") replace
dyntext "dd_do_ex_3backticks.smd", saving("dd_do_ex_3backticks.md") replace
