
sysuse auto
summarize mpg
scalar mu = r(mean)

regress price mpg
estimates store base

matrix A = e(b)
matrix list A

matrix A[1, 2] = _b[_cons] + _b[mpg]*mu
matrix A[rownumb(A,"y1"), colnumb(A,"_cons")] = _b[_cons] + _b[mpg]*mu
matrix list A


capture program drop recenter
program define recenter, eclass  
  version 12
  syntax , matrix(name) mu(real)
  di "`mu'"
  matrix dir
  matrix list `matrix'
  matrix `matrix'[rownumb(`matrix',"y1"), colnumb(`matrix',"_cons")] = _b[_cons] + _b[mpg]*mu
  ereturn repost b = `matrix'
end
  
recenter , matrix(A) mu(`=mu')

estimates table base .
