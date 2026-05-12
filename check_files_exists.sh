#Check if the Documents exsits
if [ -d"$HOME/Documents" ]; then
   echo "Documents : Exists"
else
   echo "Doucments : Doesn't Exists"
fi
#Check if the linux practice file exsits
if [ -d"$HOME/ayman/linux_practice" ]; then
   echo "Linux_practice : Exists"
else
   echo "linux_practice : Doesn't  Exists "
fi


