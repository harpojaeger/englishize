#!/bin/bash
clear
sudo find /  -name *.lproj ! -name en*.lproj -print0 | xargs -0 du | awk '
BEGIN{
printf("\033[s")
Ssuff = "KB_MB_GB_TB"
split(Ssuff, suff, "_")
}{

sum += $1
count+=1
i=1
hsize = sum
while (hsize > 1024) {
  hsize=hsize/1024
  i++
}

  printf("\033[K%d files, %.2f %s\n\033[K%.60s\n",count,hsize,suff[i],$2)
    printf("\033[u")
}
END{
printf("\n\n")
}
'