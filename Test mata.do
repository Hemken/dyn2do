cd "Z:/PUBLIC_web/Stataworkshops/dyn2do"

mata: mata clear
run docread.mata
run docwrite.mata
run mark_text_blocks.mata

* test docread()
local filename "Z:\PUBLIC_web\Stataworkshops\file_equal\README.txt"
mata:	
X=docread("`filename'")
X
end

* test dyn2do sequence
local filename1 "examples\dd_do_ex.smd"
local filename2 "examples\dd_do_ex.do"
// both <<dd_do>> and <<dd_ignore>>
mata:	
X=docread("`filename1'")
do_blocks=mark_text_blocks(X, "<<dd_do", "<</dd_do>>", 0)
ignore_blocks=mark_text_blocks(X, "<<dd_ignore", "<</dd_ignore>>", 0)
unlink("`filename2'")
docwrite("`filename2'", select(X, do_blocks :& !ignore_blocks))
end

type "`filename2'"
