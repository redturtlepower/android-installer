#!/bin/bash
####################
# install openjdk
####################
sudo apt-get install openjdk-8-jdk

####################
# install SDK
####################
if [ ! -f ./sdk.zip ]; then
    curl -sL --url https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip --output sdk.zip
fi
sudo apt-get install unzip
rm -r $HOME/sdk/android-sdk
mkdir -p $HOME/sdk/android-sdk
unzip sdk.zip -d $HOME/sdk/android-sdk && sudo rm sdk.zip
cd $HOME/sdk/android-sdk/tools/bin
sudo echo yes | ./sdkmanager "build-tools;27.0.3" "platforms;android-24"

# set path => PATH will be found if SSH'ing into this system.
# If called from an ordinary terminal opened during a session, the PATH will not contain following directories.
echo 'export ANDROID_HOME=$HOME/sdk/android-sdk' >> ~/.bash_profile
echo 'export PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_HOME}/build-tools/27.0.3/' >> ~/.bash_profile
. ~/.bash_profile
echo "PATH:"${PATH}
echo "ANDROID_HOME:"${ANDROID_HOME}

####################
# install NDK
####################
if [ ! -f ./ndk.zip ]; then
    curl -sL --url https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip --output ndk.zip
fi
unzip ndk.zip -d $HOME/sdk/android-sdk/ndk-bundle && sudo rm ndk.zip

# set permissions
sudo chown -R $USER:$USER $HOME/sdk

