# this is create Single File db template mapper

filePath=''

if [ "$#" -eq 1 ]; then
	filePath=$1
else
	echo "please input write file path"
	exit 0
fi

# read file content
fileName=${filePath##*/}
fileNameOrigin=${fileName%.*}
echo "read from tmp"$filePath
echo "tmp name "$fileName
echo "tmp origin name "$fileNameOrigin

targetDirPath="target/$fileNameOrigin"
test -d $targetDirPath && rm -rf $targetDirPath
mkdir $targetDirPath
echo "success create target path"$targetDirPath

# create db file ..
# TODO

# create model ..
./createModel.sh $fileNameOrigin $filePath $targetDirPath

# create db mapper ..
./createMapper.sh $fileNameOrigin $filePath $targetDirPath

