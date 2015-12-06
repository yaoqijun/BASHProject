#	this is main create db mapper
echo "start crete db mapper"

# create single tmp mapper 
function createSingleDBMapper(){
	./createSingle.sh $1
}

sourceFiles=$(ls "source"/*.tmp | awk '{print $1}')

for sourceFile in $sourceFiles
do
	createSingleDBMapper $sourceFile 
done
