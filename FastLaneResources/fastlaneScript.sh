#/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

#Args for all calls
outputPath="$1"
username="$2"
password="$3"
team="$4"
lane="$5"

#Special args used differently based on lanes
extraArg0="$6"
extraArg1="$7"
extraArg2="$8"
extraArg3="$9"
extraArg4="$10"

#call below worked on vapor but not mac. 
#fastlane certificate_lane username:"$username" password:"$password" profile:"$profile"

/usr/local/bin/fastlane "$lane" outputPath:"$outputPath" username:"$username" password:"$password" team:"$team" extraArg0:"$extraArg0" extraArg1:"$extraArg1" extraArg2:"$extraArg2" extraArg3:"$extraArg3" extraArg4:"$extraArg4"
#bundle exec /usr/local/bin/fastlane "$lane" outputPath:"$outputPath" username:"$username" password:"$password" team:"$team" extraArg0:"$extraArg0" extraArg1:"$extraArg1" extraArg2:"$extraArg2" extraArg3:"$extraArg3" extraArg4:"$extraArg4"
