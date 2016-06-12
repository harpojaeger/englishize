#!/bin/bash
clear
sudo find /Applications -type d -iname *.lproj ! -iname base.lproj ! -iname en*.lproj -prune -print0 | xargs -0 du | awk '
BEGIN{
printf("\033[s")
Ssuff = "B_KB_MB_GB_TB"
split(Ssuff, suff, "_")
}{

sum += ($1*512)
count+=1
i=1
hsize = sum
while (hsize > 1024) {
  hsize = hsize/1024
  i++
}

  printf("\033[K%d folders, %.2f %s\n\033[K%.80s\n",count,hsize,suff[i],$0)
  printf("\033[u")
  print $0 > "du.out"
    
}
END{
printf("\n\n")
}
'