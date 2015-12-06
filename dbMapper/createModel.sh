# this is create model shell 
# param 
#		modelName	
#		sourceFile	
#		targetDir	
#config pre install
#	modeDB.mapper model type mapper 

configTypeMapperPath="config/modeDB.mapper"
index=1
currModelType=''	#currModetype 函数getModelTypeByDbType 返回结果

# validate
if [ "$#" -eq 3 ]; then
	modelName=$1
	sourceFile=$2
	targetDir=$3
else
	echo "create model param error"
	exit 0
fi

# get type convert
dbTypeList=($(cat $configTypeMapperPath | awk '{print $1}'))
dbTypeLength=${#dbTypeList[*]}

modelTypeList=($(cat $configTypeMapperPath | awk '{print $2}'))
modelTypeLength=${#modelTypeList[*]}

# by db type find model type
function getModelTypeByDbType(){
	for (( i = 0; i < dbTypeLength; i++ )); do
		#echo "currConpare "$1"--"${dbTypeList[$i]}--$i
		if [ "$1" == "${dbTypeList[$i]}" ]; then
			currModelType="${modelTypeList[$i]}"
			return 0
		fi
	done
	echo "*** error do not find db type ***"$1
	currModelType="error"
	exit 0
}

# echo "start"
# getModelTypeByDbType "int"
# echo $currModelType
# getModelTypeByDbType "varchar"
# echo $currModelType
# echo "end"

# get source data
columns=($(cat $sourceFile | awk '{print $1}'))
columnsType=($(cat $sourceFile | awk '{print $2}'))
columnsComment=($(cat $sourceFile | awk '{print $3}'))
columnsLength=${#columns[@]}

# create file
targetModelFile=$targetDir"/"$modelName".model"
test -f $targetModelFile && rm -rf $targetModelFile
touch $targetModelFile
echo "success create file : "$targetModelFile

# add content
echo '@Data' >> $targetModelFile
echo "public class "$modelName" implements Serializable {\n" >> $targetModelFile
echo $columnsLength
for (( j = 0; j < $columnsLength; j++ )); do
	getModelTypeByDbType ${columnsType[$j]}
	echo "\tprivate "$currModelType" "${columns[$j]}"; \t\\\\\\"${columnsComment[$j]}"\n" >> $targetModelFile
done
echo '}' >> $targetModelFile


