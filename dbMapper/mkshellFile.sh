# make shell 777 file 
# in current dir

fileName=''

if [ $# -eq 1 ]; then
	fileName=$1
else
	echo "Please input right file name" 
fi

echo $fileName
touch $fileName
chmod 777 $fileName