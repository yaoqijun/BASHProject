# create mapper content
# param fileNameOrigin filePath targetDirPath
# config repalceReg

replacePath="config/A_Z.replace"

if [ "$#" != "3" ]; then
	echo "create mapper content error"
	exit 0
fi

fileNameOrigin=$1
filePath=$2
targetDirPath=$3

bigReplace=($(cat $replacePath | awk '{print $1}'))
bigReplaceLength=${#bigReplace[*]}
subReplace=($(cat $replacePath | awk '{print $2}'))

# replace sub char to upcase
function replaceSubChar(){
	for (( i = 0; i < $bigReplaceLength; i++ )); do
		replaceSubChar_param=${replaceSubChar_param//${subReplace[$i]}/${bigReplace[$i]}}
	done
}

#read content 
columns=($(cat $filePath | awk '{print $1}'))
columnsLength=${#columns[*]}

#create  properties
properties=()
for (( j = 0; j < columnsLength; j++ )); do
	replaceSubChar_param=${columns[$j]}
	replaceSubChar
	properties[$j]=$replaceSubChar_param
done

# export file content
targetMapperFile=$targetDirPath"/"$fileNameOrigin".mapper"
test -f $targetMapperFile && rm -rf $targetMapperFile
touch $targetMapperFile

echo "result : " >> $targetMapperFile
for (( k = 0; k < $columnsLength; k++ )); do
	echo "<result property="${properties[$k]}"\" column=\""${columns[$k]}"\" />" >> $targetMapperFile
done

echo "" >> $targetMapperFile
echo "" >> $targetMapperFile

echo "columns : " >> $targetMapperFile
columns_str=${columns[0]}
for (( i = 1; i < $columnsLength; i++ )); do
	columns_str=$columns_str","${columns[i]}
done
echo $columns_str >> $targetMapperFile

echo "" >> $targetMapperFile
echo "" >> $targetMapperFile

echo "values : " >> $targetMapperFile
values_str="\${"${properties[0]}"}"
for (( i = 1; i < $columnsLength; i++ )); do
	values_str=$values_str", \${"${properties[$i]}"}"
done
echo $values_str >> $targetMapperFile

echo "" >> $targetMapperFile
echo "" >> $targetMapperFile

echo "update : " >> $targetMapperFile
for (( i = 0; i < $columnsLength; i++ )); do
	echo "<if test=\""${properties[$i]}"!=null\">"${columns[$i]}"=#{"${properties[$i]}"},</if>" >> $targetMapperFile
done

