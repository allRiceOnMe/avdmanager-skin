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

# LIST AVAILABLE AVDS
AVDS=($($AVDMANAGER list avd | grep -w "Name:" | awk '{print $2}'))
if [ -z "$AVDS" ]
  then
        echo -e "No AVDs found."
        exit 1
fi
COUNTER=0
for AVD in "${AVDS[@]}"
do
	echo "[$COUNTER] $AVD"
	COUNTER=$((COUNTER+1))
done

# USER SELECTS AVD-ID
AVD_ID="${#AVDS[@]}"
while [[ ! "$AVD_ID" =~ ^[0-9]+$ ]] || [[ ! "$AVD_ID" -lt "${#AVDS[@]}" ]]; do
	echo -e "Please select the AVD number: \c"
	read AVD_ID
done
AVD="${AVDS[$AVD_ID]}"

# LIST AVAILABLE SKINS
SKINS=($(ls $ANDROID_SKINS_DIRECTORY))
if [ -z "$SKINS" ]
  then
        echo -e "No Skins found."
        exit 1
fi
COUNTER=0
for SKIN in "${SKINS[@]}"
do
        echo "[$COUNTER] $SKIN"
        COUNTER=$((COUNTER+1))
done

# USER SELECTS SKIN-ID
SKIN_ID="${#SKINS[@]}"
while [[ ! "$SKIN_ID" =~ ^[0-9]+$ ]] || [[ ! "$SKIN_ID" -lt "${#SKINS[@]}" ]]; do
        echo -e "Please select the Skin number: \c"
        read SKIN_ID
done
SKIN="${SKINS[$SKIN_ID]}"

# LINES TO APPEND
declare -a APP=("skin.name=$SKIN"
		"skin.path=$ANDROID_SKINS_DIRECTORY/$SKIN"
		"hw.gpu.enabled=yes"
		"hw.gpu.mode=auto"
		"hw.ramSize=1536"
		"showDeviceFrame=yes"
		"skin.dynamic=yes"
		)

# GET PATH OF AVD
AVD_PATH=$($AVDMANAGER list avd | grep -A 2 -w $AVD | grep Path | awk '{print $2}')
if [ -z "$AVD_PATH" ]; then
	echo "AVD Path not found"
	exit 1
fi

# APPEND LINES IF NOT EXIST
CONF_FILE=$AVD_PATH/config.ini
for line in "${APP[@]}"
do
   grep -q -F "$line" $CONF_FILE || echo "$line" >> $CONF_FILE
done

