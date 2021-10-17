#!/bin/bash
# File intended to replace the sam build command. Not working yet

srcFolder="src"
handlers=`ls -a "$srcFolder/handlers"| cut -d "." -f 1`
awsOutput=".aws-sam"
awsOutputBuild="$awsOutput/build"
dependenciesLayer="$awsOutputBuild/RuntimeDependenciesLayer/nodejs"
temporaryTsConfigPath="tsconfig-only-handler.json"

echo "Installing dependencies"
npm install --silent --quiet --no-fund --loglevel silent --no-audit --no-progress

if [ -f "$awsOutput" ] ; then
    rm -r "$awsOutput"
fi



for handler in $handlers
do
    echo "Building $handler handler"
    handlerDestPath="$awsOutputBuild/$handler/dist"
    handlerPath="$srcFolder/handlers/$handler.ts"
    
    echo "{\"extends\": \"./tsconfig.json\",  \"include\": [\"$handlerPath\"],\"compilerOptions\":{\"outDir\":\"$handlerDestPath\"} }" > $temporaryTsConfigPath

    node_modules/typescript/bin/tsc -p $temporaryTsConfigPath
done


echo "Building RuntimeDependenciesLayer"
mkdir -p $dependenciesLayer
cp package.json package-lock.json $dependenciesLayer
npm install --silent --quiet --no-fund --no-audit --no-progress --loglevel silent --production --prefix $dependenciesLayer
rm "$dependenciesLayer/package.json" # to avoid rebuilding when changes doesn't relate to dependencies


cp samconfig.toml "$awsOutput/build.toml"
cp template.yml $awsOutputBuild

rm $temporaryTsConfigPath
echo "Done"