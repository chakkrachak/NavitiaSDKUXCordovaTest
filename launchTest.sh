#!/bin/bash

# TRACING ON
# set -x

CordovaNavitiaSDK_ProjectName='CDVNavitiaSDKUX'
CordovaNavitiaSDK_LocalPath=$1

# Utils
function ensureFileExists {
    if [  -f "$*" ]; then
        echo "$* exists => OK"
    else
        echo "$* does not exist => ## PROBLEM FILE NOT FOUND ##";
        exit 1;
    fi
}

function ensureFolderExists {
    if [  -d "$*" ]; then
        echo "$* exists => OK"
    else
        echo "$* does not exist => ## PROBLEM FOLDER NOT FOUND ##";
        exit 1;
    fi
}

function cleanWorkspace {
    rm -rf ./$CordovaNavitiaSDK_ProjectName
    git checkout . && git clean -fd
    rm -rf ./CordovaAppTest/platforms/ios/build/emulator/CordovaAppTest.app.dSYM
    rm ./CordovaAppTest/platforms/android/build/outputs/apk/android-debug.apk
}

# RETRIEVE NAVITIA SDK
function retrieveNavitiaSDK_master {
    git clone git@github.com:CanalTP/$CordovaNavitiaSDK_ProjectName.git
}

# Script

cleanWorkspace

## RETRIEVE SDK
if [ -z "$CordovaNavitiaSDK_LocalPath" ] ; then
    retrieveNavitiaSDK_master
    CordovaNavitiaSDK_LocalPath=../$CordovaNavitiaSDK_ProjectName
fi

## GO TO APP TEST FOLDER
cd CordovaAppTest

## INSTALL PLUGIN
npm rebuild node-sass --force
ionic cordova plugin add $CordovaNavitiaSDK_LocalPath

## BUILD ANDROID
ionic cordova platform add android
ionic cordova build android
ensureFileExists "./platforms/android/build/outputs/apk/android-debug.apk"

## BUILD IOS
ionic cordova platform add ios
ionic cordova build ios
ensureFolderExists "./platforms/ios/build/emulator/CordovaAppTest.app.dSYM"

## GO BACK TO MAIN FOLDER
cd ..
