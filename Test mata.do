cd "Z:/PUBLIC_web/Stataworkshops/dyn2do"

mata: mata clear
run docread.mata
run docwrite.mata
run mark_text_blocks.mata
run expand_display_rows.mata
run dyn2do.mata

* test Stata Corp. example
local filename1 "http://www.stata-press.com/data/r15/markdown/dyndoc_ex.txt"
local filename2 "examples\test.do"
mata:
	dyn2do("`filename1'", "`filename2'")
end

file_equal "`filename2'" using "examples\dyndoc_ex.do_bm"
assert r(equal) == 1

* with 2 on a line
local filename1 "examples/dd_display_ex.smd"
local filename2 "examples\test.do"
mata:
	dyn2do("`filename1'", "`filename2'")
end

file_equal "`filename2'" using "examples\dd_display_ex.do_bm"
assert r(equal) == 1
