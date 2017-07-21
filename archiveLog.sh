# Script to archive Weblogic server logs and moved to backup directory 1st of each month
# Crontab entry : 0 0 1 * *
# Usage: archiveLogs.sh <domainname>
# Author: Palak Desai
#==========================

#! /bin/bash

# Assign command line paramenter to a variable
weblogic_domain=$1

# Based on domain name supplied find admin and managed server log location
admin_logdir=$weblogic_domain/servers/admin/logs
managedserver_logdir=$weblogic_domain/servers/managedserver/logs

# Backup or archive directory
archive_location=$HOME/archive

# Zip file datestamp
date=`date +%Y-%m-%d`
archive=log_archive.$date.zip

# Create temp directory to store admin and managed server logs
mkdir log_archive

# Move files older than 30days to temopary directory
cd $HOME/$admin_logdir
find . -type f -mtime +30 -exec mv -t $HOME/log_archive {} \;

cd $HOME/$managedserver_logdir
find . -type f -mtime +30 -exec mv -t $HOME/log_archive {} \;

# Creating zip file and moving to archive location 
cd ~
zip -r $archive log_archive
mv $archive $archive_location

# Remove temporary file
rm -rf $HOME/log_archive
