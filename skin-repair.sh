#!/bin/bash

# CHECK IF ANDROID_SDK_ROOT IS SET AND NON-EMPTY
if [ -z "$ANDROID_SDK_ROOT" ]; then
	echo "Need to set ANDROID_SDK_ROOT"
	echo "See https://developer.android.com/studio/command-line/variables.html#android_sdk_root for help"
    exit 1
fi

# ANDROID VARIABLE
ANDROID_SKINS_DIRECTORY=$ANDROID_SDK_ROOT/skins
AVDMANAGER=$ANDROID_SDK_ROOT/tools/bin/avdmanager

# INPUT PARAMS
IN_AVD=$1
IN_SKIN=$2

# LINES TO APPEND
declare -a APP=("skin.name=$IN_SKIN"
		"skin.path=$ANDROID_SKINS_DIRECTORY/$IN_SKIN"
		"hw.gpu.enabled=yes"
		"hw.gpu.mode=auto"
		"hw.ramSize=1536"
		"showDeviceFrame=yes"
		"skin.dynamic=yes"
		)

# GET PATH OF AVD
AVD_PATH=$($AVDMANAGER list avd | grep -q -A 2 -w $IN_AVD | grep -q Path | awk '{print $2}')
if [ -z "$AVD_PATH" ]; then
	echo "AVD '$IN_AVD' not found"
	echo "Check 'avdmanager list avd' for availabe AVDs"
	exit 1
fi
echo "Path: '$AVD_PATH'"

# CHECK IF VALID SKIN INPUT
for SKIN in "$ANDROID_SKINS_DIRECTORY"/*
do
	SKIN=$(basename "$SKIN")
	if [ "$IN_SKIN" == "$SKIN" ]; then
		break
	else
		unset SKIN
	fi 
done
if [ -z "$SKIN" ]; then
	echo "Skin '$IN_SKIN' not found"
	echo "Check 'ls $ANDROID_SKINS_DIRECTORY' for availabe Skins"
	exit 1
fi

# APPEND LINES IF NOT EXIST
CONF_FILE=$AVD_PATH/config.ini
for line in "${APP[@]}"
do
   grep -q -F "$line" $CONF_FILE || echo "$line" >> $CONF_FILE
done

