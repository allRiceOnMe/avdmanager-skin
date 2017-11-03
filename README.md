# avdmanager-skin

Repair the AVD's `config.ini` file to get the correct skin parameters, after the creation using the `avdmanager`.

## Problem Description

If the `avdmanager` is used to create an AVD with the `-d` or `--device` option, it fails to set the correct skin parameters within the `config.ini` file. This results in a misconfigured resolution when starting the AVD with the `emulator` command.

### Step 1 - AVD Creation

Invoke the `avdmanager` to create an AVD using the `--device` option, example:

```
$ avdmanager create avd --force --name "testAVD" --package "system-images;android-23;google_apis;x86_64" --path ~/Projects/Test.avd --device "Nexus 5X"
```

### Step 2 - AVD Usage

Now run the AVD using the `emulator -avd testAVD` command. The snapshot shows what is meant by *misconfigured resolution*:  

<img src="https://user-images.githubusercontent.com/16719316/32376261-919511d8-c0a4-11e7-90e3-e04f47ab9988.png" width="200" />

## Usage

Ok, now how to solve the problem described above? -> Use the script from this repo. 

```
$ ./skin-repair.sh
[0] Android_Accelerated_Nougat
[1] Android_ARMv7a_Nougat
[2] KitKat
[3] Lollipop
[4] Nougat
[5] testAVD
Please select the AVD number: 5
[0] AndroidWearRound
[1] AndroidWearSquare
[2] galaxy_nexus
[3] nexus_10
[4] nexus_4
[5] nexus_5
[6] nexus_5x
[7] nexus_6
[8] nexus_6p
[9] nexus_7
[10] nexus_7_2013
[11] nexus_9
[12] nexus_one
[13] nexus_s
[14] pixel
[15] pixel_c
[16] pixel_xl
[17] tv_1080p
[18] tv_720p
Please select the Skin number: 6
```

That's all. Now run the AVD again (`$ emulator -avd testAVD`) and enjoy the correct resolution:

<img src="https://user-images.githubusercontent.com/16719316/32377437-fd293052-c0a7-11e7-93ce-6f653f6320be.png" width="300" />
