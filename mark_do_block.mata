mata:
// mata drop mark_dd_do()
real colvector mark_dd_do(string colvector doc) {
	real colvector dd_do, starts, stops
	dd_do=.; starts=.; stops=.
	starts=(ustrpos(doc, "<<dd_do"):==1)
	stops=(ustrpos(doc, "<</dd_do"):==1)
	dd_do=runningsum(starts-stops)-starts
	// just what is inside the blocks
	return(dd_do)
	}
end
