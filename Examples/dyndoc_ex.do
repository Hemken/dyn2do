sysuse auto, clear
describe
assert mpg > 0 & mpg < 100
summarize weight
display  %4.2f `r(min)'
display  %4.2f `r(max)'
display  %4.2f `r(max)'-`r(min)'
scatter mpg weight, mcolor(blue%50)
