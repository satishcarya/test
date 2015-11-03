#!/bin/sh

# Author: Piyush Garg
# Student ID: S3218012

#This script is designed to make the Interactive Menu Item, which performs some basic operations 
#such as Renaming the File, Lowering the File name, copy/Move, Text Search. In this script some of 
#the menu items works on the Absolute or Relative Pathnames.

#Building the Main Menu

mainmenu()
{
#Clearing the Screen

clear

#Menu Options

printf "******************************************\n"
printf "\n"
printf "Interactive File Management System\n"
printf "--------------------------------------\n"
printf "\n"
printf "1)Rename the File\n"
printf "2)Rename the Files to LowerCase\n"
printf "3)Copy or Move the File\n"
printf "4)Find text inside the File\n"
printf "5)Exit\n"
printf "Enter your Choice:\n"
printf "\n"
printf "******************************************\n"

read response

if [ $? = 0 ];then

#eval is for reference for response

eval $1=\${response}
return 0
fi

}

# For Renaming the File Name
Rename_File()
{

echo "Enter the Path with the File name which you want to Rename: "
read path

pathname=`dirname $path`

echo ""
echo "Enter the New File name that you want to replace with: "
read Filename
echo ""

#Checking the path exists or not
if [ -f $path ] ;then

    mv $path $pathname/$Filename

    echo "The file has been Renamed."
    echo ""
       echo "Press Enter to Exit"
       read exit

else 
    echo "File does not exits."
    echo ""
       echo "Press Enter to Exit"
       read exit

fi

}

# For converting the File name to the Lower case
ConvertFile()
{
echo "Enter the name of the File (Works on Absolute Path or Current Directory)"
read Filename

#Checking the Filename exists or not
if [ -f $Filename ];
then
    lowerfile=`echo $Filename | tr [A-Z] [a-z]`
    mv $Filename $lowerfile

    echo ""
    echo "File name Converted"
    echo "Press Enter to Exit"
       read exit

else
    echo "File name not found"
    echo ""
    echo "Press Enter to Exit"
       read exit

fi

}

# For Copying or Moving the File
Copy_Move()
{

echo "Enter the Path with the File name you want to Copy: "
read path
echo ""

#Checking the Filename exists or not.
if [ -f $path ];then

    echo "Enter the New name for the File that you are coping: "
    read newFile
    echo ""

    echo "Enter the Path where you want the File to be Copied: "
    read newPath
    echo ""

if [ -d $newPath ];then

       cp $path $newPath/$newFile
    echo "The file has been Copied or Moved."
    echo ""
    echo "Press Enter to Exit"
    read exit

fi
fi
}


#For Finding the text in the File (works for a String)
#This can sometime work with the relative path. Some time do not work with 
#the Relative Path.
Find_Text()
{
echo "Enter the Path without the name of File(Current Directory Path): "
read path

#Cheacking the Directory exists or not. 
if [ -d $path ];then

       echo ""
       echo "Enter the name of the File you want to search in: "
       read Filename
       echo ""

               if [ -f $Filename ];then

                       echo "Enter the Text you want to Search for: "
                       read text
                       echo ""

                       find $path -name "$Filename" | xargs grep "$text"

                       echo ""
                       echo "Press Enter to Exit"
                       read exit
        else
            echo ""
            echo "File Name not found"
            echo "Press Enter to Exit"
                       read exit

               fi
else
       echo "Invalid Path."

fi
}


#Functions for the Menu options selected
while true

do
    mainmenu option

    case "$option" in

#Functions for every menu Item, the user selects.

        "1")Rename_File;;
        "2")ConvertFile;;
        "3")Copy_Move;;
        "4")Find_Text;;
        "5")exit 0;;
          *)echo "Invaid Option. Please press Enter to Continue...\n"
            read input;;
    esac

done

#Refrences:

#1. http://www.unix.com/shell-programming-scripting/3799-uppercase-lowercase.html
#2. http://www.cyberciti.biz/faq/how-to-use-linux-unix-tr-command/
#3. http://www.freeos.com/guides/lsst/

