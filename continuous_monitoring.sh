# Script to monitor instances status on a URL and email about fail status
# Usage: continuous_monitoring.sh url
# Author: Palak Desai
##########################################################################

#!/bin/bash

#Get Date
datestamp=`date +"%Y%m%d_%H%M%S"`

#Set curl variable
CT="%{http_code}"

#Checking instance status on URL
while read -ru 4 LINE; do
    read -r REP < <(exec curl -s -o /dev/null -I https://"$LINE" -w %{http_code} 2>&1)
    echo "$LINE $REP" >> sites.txt
done 4< "$1"

#Filtering offline sites
grep -v "200" sites.txt > unhealthy.txt

#Preparing list of failed site.
count=`wc -l < unhealthy.txt`
if [ $count == "0" ] ; then
  echo "All Sites are good."
else
  echo "**************" >> emailbody.txt
  echo "Offline Sites:" >> emailbody.txt
  echo "**************">> emailbody.txt
  echo "
" >> emailbody.txt
  awk '{print "Site URL: " $1 ", is down with HTML code: " $2 }' unhealthy.txt >> emailbody.txt
  echo "
" >> emailbody.txt
 
#Email offline sites
cat emailbody.txt | mailx -s "Site Health Issues Detected" email@email.com

#Create offline_sites log for date
mv ./emailbody.txt offline_sites_$datestamp.txt
fi

#Cleanup
rm unhealthy.txt

