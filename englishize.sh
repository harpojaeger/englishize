#!/bin/bash
clear
sudo find /Applications/Chicken.app -type d -iname *.lproj ! -iname uk.lproj ! -iname base.lproj ! -iname en*.lproj -prune -print0 | xargs -0 du -s | awk -v p=$$ -F "\t" '
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
  print $2 > sprintf("du-%s.out",p)
}
'

if [ -s du-$$.out ]; then
  printf "\n\n"
  printf "Preview folders slated for deletion? (Y/n)? "
  read action
  
  if [ $action = "Y" ]; then
    less du-$$.out
  fi

  printf "Delete folders now (Y/n)? "
  read action

  if [ $action = "Y" ]; then
    awk -v q="'" '{print q $0 q }' du-$$.out | xargs sudo rm -rf
  fi
  rm du-$$.out

else
  echo "No folders found."
fi