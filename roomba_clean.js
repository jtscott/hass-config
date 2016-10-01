#!/usr/bin/env node

var dorita980 = require('dorita980'); //https://github.com/koalazak/dorita980
var secretsFile = "./secrets.json"
var secrets

try {
  secrets = require(secretsFile)
}
catch (err) {
  config = {}
  console.log("unable to read file '" + secretsFile + "': ", err)
}

var myRobotViaCloud = new dorita980.Cloud(secrets.username, secrets.password); // No need robot IP

// start to clean!
myRobotViaCloud.start().then((response) => {
  console.log(response);
}).catch((err) => {
  console.log(err);
});
