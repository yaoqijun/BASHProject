# this is create db sql to create table
# param fileNameOrigin filePath targetDirPath
# config null

if [ "$#" != "3" ]; then
	echo "create DB sql param error"
	exit 0
fi

fileNameOrigin=$1
filePath=$2
targetDirPath=$3

# echo $fileNameOrigin
# echo $filePath
# echo $targetDirPath

columns=($(cat $filePath | awk '{print $1}'))
columnsType=($(cat $filePath | awk '{print $2}'))
columnsComment=($(cat $filePath | awk '{print $3}'))
columnsSize=($(cat $filePath | awk '{print $4}'))
length=${#columns[*]}

# create target file
targetFilePath=$targetDirPath"/"$fileNameOrigin".sql"
test -f $targetFilePath && rm -rf $targetFilePath
echo $targetFilePath

# input content
echo "CREATE TABLE \`"$fileNameOrigin"\` (" >> $targetFilePath

for (( i = 0; i < length; i++ )); do
	echo "\t\`"${columns[$i]}"\` "${columnsType[$i]}"("${columnsSize[$i]}") DEFAULT NULL COMMENT '"${columnsComment[$i]}"'," >> $targetFilePath
done
echo "\tPRIMARY KEY (\`id\`)" >> $targetFilePath
echo ") ENGINE=InnoDB DEFAULT CHARSET=utf8;" >> $targetFilePath

