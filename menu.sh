# Menu based script to perform File operations based on user selection
# Author: Palak Desai
###################################################################### 

clear screen

# This loop infinitely until user select to exit
while true
do

# Display Menu of file operations
echo "
	Enter the number
        ----------------
	1. Make a file.
	2. Display contents
	3. Copy the file
	4. Rename the file
	5. Delete the file
	6. Exit
"
# Read User input
read option

# Case statement to perform required action according to the user option
case $option in
	1) echo "Please enter the filename to be made"
	   read fname
	   if [ -e $fname ]
	   then
	   echo "Sorry,the file already exists"
	   else
    	   echo "Please enter file content & press ctrl+d when finished"
	   cat > $fname
	   fi
	   continue
	;;
	2) echo "Please enter the filename to be displayed"
	   read fname
	   if [ -e $fname ]
	   then
	   cat $fname
	   else
 	   echo "Sorry,file does not exist"
	   fi
	   continue
	;;
	3) echo "Please enter the filename to be copied"
	   read fname
	   if [ -r $fname ]
	   then
	   echo "Please enter the filename to which contents should be copied"
	   read fname1
	   if [ ! -e $fname1 ]
	   then
	   cp $fname $fname1
	   else
	   echo "Error,target file already exists"
	   fi
	   else
	   echo "File does not exist or it is not readable"
	   fi
	   continue
	;;
	4) echo "Please enter the filename to be renamed"
	   read fname
	   if [ -r $fname ]
	   then
	   echo "Enter the new filename"
	   read fname1
	   if [ ! -e $fname1 ]
	   then
           mv $fname $fname1
	   else
	   echo "Sorry, file with new name already exists"
	   fi
	   else
	   echo "File does not exist or it is not readable"
	   fi
	   continue
	;;
	5) echo "Enter the filename to be deleted"
	   read fname
	   if [ -w $fname ]
	   then
	   rm -i $fname
	   else
	   echo "File does not exist or you do not have write permission"
	   fi
	   continue
	;;
	6) exit
	;;
	*) echo "invalid option"
	   continue
	;;
esac
done

