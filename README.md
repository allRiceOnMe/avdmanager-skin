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

- The first parameter is the name of the AVD (such as `testAVD`). 

- The second parameter is the socalled ["predefined skin"](https://developer.android.com/studio/run/managing-avds.html#emulator-skin) (such as `nexus_5x`). It is the skin that belongs to the selected device. The command `$ ls $ANDROID_SDK_ROOT/skins` lists all predefined skins.

```
$ ./skin-repair.sh testAVD nexus_5x
```

Now run the AVD again (`$ emulator -avd testAVD`) and enjoy the correct resolution:

<img src="https://user-images.githubusercontent.com/16719316/32377437-fd293052-c0a7-11e7-93ce-6f653f6320be.png" width="300" />
