cd "Z:/PUBLIC_web/Stataworkshops/dyn2do"

mata: mata clear
run docread.mata
run mark_text_blocks.mata

* test docread()
local filename "Z:\PUBLIC_web\Stataworkshops\file_equal\README.txt"
mata:	
X=docread("`filename'")
X
end

* test mark_text_blocks()
local filename "examples\dd_do_ex.smd"
// both <<dd_do>> and <<dd_ignore>>
mata:	
X=docread("`filename'")
X
do_blocks=mark_text_blocks(X, "<<dd_do", "<</dd_do>>", 0)
X,strofreal(do_blocks)
end

