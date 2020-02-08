# Fastlane

A minimal Swift wrapper around select Fastlane operations. This does not yet use [Fastlane's Swift classes](https://docs.fastlane.tools/getting-started/ios/fastlane-swift/) but may explore in the future. 

**Setup**

- Install Fastlane on a Mac or Linux OS ([official instructions](https://docs.fastlane.tools/getting-started/ios/setup/))
- The source includes a "FastlaneResources" directory. This directory includes files that Fastlane will use under the covers (Ruby source code). This directory needs to be available somewhere that the final executable will be able to access.
- The aforementioned "FastlaneResources" directory includes a script used to trigger Fastlane. The permissions need adjusted for execution.
```
chmod u+x FastlaneResources/fastlaneScript.sh
```
**Running**

-If you have 2-factor authentication setup, you will need to run Fastlane from the command line in order to input your credentials.
-Create a client and execute:

```
let resourceDirectory = "<path to FastLaneResources directory>"
let client = FastlaneClient(username: <apple username>, password: <apple password>, team: <apple team id>, resourcesDirectoryPath: resourceDirectory)

//Now use the client to do things.
```
