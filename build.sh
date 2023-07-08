#! /bin/bash

read -p "App version: " version;

appName="what-if-v0.1"
directory="outputs"
release="$directory/$(date +"%Y-%m-%d")"
web="$release/web/assets/"

if [ ! -d "$directory" ];
then 
	mkdir outputs;
fi

if [ -d "$release" ];
then
	rm -rf $release;
fi

flutter clean;
flutter build apk --split-per-abi; cp build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk $directory/;
flutter build appbundle; cp build/app/outputs/bundle/release/app-release.aab $directory/;
flutter build web; cp -r build/web $directory/;

mkdir $release; mv $directory/app-armeabi-v7a-release.apk $directory/app-release.aab $directory/web $release;

mv $release/app-armeabi-v7a-release.apk $release/$appName.$version.apk;
mv $release/app-release.aab $release/$appName.$version.aab;

zip -r $release/web.zip $release/web;
