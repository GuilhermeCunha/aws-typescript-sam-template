root=`pwd`
handlers=`ls -a ./src/handlers | cut -d "." -f 1`

awsOutput="$root/.aws-sam"
awsOutputBuild="$awsOutput/build"

rm -r $awsOutput

for handler in $handlers
do
    dest="$awsOutputBuild/$handler"
    mkdir -p $dest
    cp -r dist $dest
    echo $dest
done


mkdir -p "$awsOutput/nodejs"
cp package.json package-lock.json "$awsOutput/nodejs/"
npm install --production --prefix "$awsOutput/nodejs/"
rm "$awsOutput/nodejs/package.json" # to avoid rebuilding when changes doesn't relate to dependencies