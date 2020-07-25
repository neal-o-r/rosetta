#!/bin/bash

awk '
{counter=0};
/[cork]/ {counter++};
/[galway]/ {counter++};
/[mayo]/ {counter++};
/[donegal]/ {counter++};
/[kerry]/ {counter++};
/[tipperary]/ {counter++};
/[clare]/ {counter++};
/[tyrone]/ {counter++};
/[antrim]/ {counter++};
/[limerick]/ {counter++};
/[roscommon]/ {counter++};
/[down]/ {counter++};
/[wexford]/ {counter++};
/[meath]/ {counter++};
/[derry]/ {counter++};
/[kilkenny]/ {counter++};
/[wicklow]/ {counter++};
/[offaly]/ {counter++};
/[cavan]/ {counter++};
/[waterford]/ {counter++};
/[westmeath]/ {counter++};
/[sligo]/ {counter++};
/[laois]/ {counter++};
/[kildare]/ {counter++};
/[fermanagh]/ {counter++};
/[leitrim]/ {counter++};
/[armagh]/ {counter++};
/[monaghan]/ {counter++};
/[longford]/ {counter++};
/[dublin]/ {counter++};
/[carlow]/ {counter++};
/[louth]/ {counter++};
{print $0 " " counter;}' ../data/enable1.txt | \

awk '($2 == 31 && length > m) { m = length; a = $1 } END { print a }'



