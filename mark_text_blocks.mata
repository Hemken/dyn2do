mata:
/* assumes tags are at the beginning of lines */	
real colvector mark_text_blocks(string colvector doc, ///
		string scalar st_tag, string scalar end_tag, ///
		real scalar include_tags) {
	real colvector blocks, starts, stops
	blocks=.; starts=.; stops=.
	starts=(ustrpos(doc, st_tag):==1)
	stops=(ustrpos(doc, end_tag):==1)
	if (include_tags) {
		blocks=runningsum(starts-stops)+stops
		}
		else {
		// just what is inside the blocks
		blocks=runningsum(starts-stops)-starts
		}
	return(blocks)
	}
end
