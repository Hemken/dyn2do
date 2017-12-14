Using <<dd_do>>
===============================================================

Let us consider an example where we study the **mpg** and **weight** variables
in **auto.dta**.  In our examples below, we will first write the commands so
that they will be displayed in our target HTML file.  Then, we will write the
commands so that Stata will process the Stata dynamic tags, displaying the
results of the Stata commands in the target HTML file.

```
<<dd_do>>
sysuse auto, clear
describe
<</dd_do>>
```

This produces the following Stata results:

```
. sysuse auto, clear
(1978 Automobile Data)

. describe

Contains data from D:\Programs\Stata15\ado\base/a/auto.dta
  obs:            74                          1978 Automobile Data
 vars:            12                          13 Apr 2016 17:45
 size:         3,182                          (_dta has notes)
----------------------------------------------------------------------------------------
              storage   display    value
variable name   type    format     label      variable label
----------------------------------------------------------------------------------------
make            str18   %-18s                 Make and Model
price           int     %8.0gc                Price
mpg             int     %8.0g                 Mileage (mpg)
rep78           int     %8.0g                 Repair Record 1978
headroom        float   %6.1f                 Headroom (in.)
trunk           int     %8.0g                 Trunk space (cu. ft.)
weight          int     %8.0gc                Weight (lbs.)
length          int     %8.0g                 Length (in.)
turn            int     %8.0g                 Turn Circle (ft.)
displacement    int     %8.0g                 Displacement (cu. in.)
gear_ratio      float   %6.2f                 Gear Ratio
foreign         byte    %8.0g      origin     Car type
----------------------------------------------------------------------------------------
Sorted by: foreign

```

