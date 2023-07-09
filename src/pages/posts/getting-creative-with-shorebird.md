---
stackbit_url_path: posts/getting-creative-with-shorebird
title: "Getting creative with Shorebird"
date: '2023-07-10T09:00:00.000Z'
excerpt: Working with shorebird to replace a manual distribution channel
tags:
  - Shorebird
  - Flutter
  - FlutterDevelopment
  - AppDeployment
template: post
thumb_img_path: https://cdn.hashnode.com/res/hashnode/image/upload/v1688732912936/2b17ed9c-a6b7-4cf7-8f48-42da5c1d1c14.webp
---

![Github CoPilot](https://cdn.hashnode.com/res/hashnode/image/upload/v1688732912936/2b17ed9c-a6b7-4cf7-8f48-42da5c1d1c14.webp)

## Some background

We have started doing initial testing with a new client, however, they place restrictions on their devices as well as what can be accessed online, this, unfortunately, includes Google Play Store. Naturally that makes getting them updates a little complicated.

The initial test group is quite small with 5 users, and they are all located at a single location, once the initial test phase is done the full rollout will include about 3000 devices across an entire country. So right now, driving 50km at 5 am, while not fun, to install updates on those devices, is most certainly not viable beyond this phase.

SO boy was I happy to have found Shorebird the week before this all started, not that I had time to try it out then...

In its early stages, it does have some complications that are less ideal for our current workflow, but those are still better than whatever the alternative would end up being.

## Version Constraints

While Shorebird allows one to build a  patch update, which by looking at the CI is done by creating a diff from the current release, the release is tied to the version in the `pubspec.yaml` file. While not actually easy itself and generally easily manageable, our workflow relies on semantic versioning both for support post-release as well as managing builds and deployments.

Under normal circumstances, one would rely only on Shorebird for more urgent hotfixes, so being tied to a release would not be a major issue as the Play Store/Appstore would handle normal features or bug fixes.

As you can imagine, however, for this scenario I would be looking at Shorebird as an additional distribution channel, and while it can only patch dart code changes, the occasional APK update that can be sent to users, either via IT support or some other means can be managed as it would be very infrequent.

However as is the nature of software development we release quite regularly, during the testing phase (we worked on-prem) we did about 10 releases, and while that is slowing down we would still be looking at 1-3 per week for the next few weeks.

### The workaround

From a release management standpoint I have defined a fixed version, unrelated to our actual application version for this client, this allows me to work with the following script

```bash
#/bin/sh

# get the current version from pubspec.yaml
pubspec_yaml=$(cat "pubspec.yaml")
version_key=$(echo "$pubspec_yaml" | grep -E "version:")
v=$(echo "$version_key" | sed -E "s/version: //g")
# Set the version to 0.0.0
fvm flutter pub run cider version 0.0.0

shorebird patch --flavor production --artifact apk

fvm flutter pub run cider version $v
```

For some clarification, this script starts by getting the actual version from the yaml and storing it in a variable.

Next, using [cider](https://pub.dev/packages/cider) I set the version to the one that would be used for this client, run the patch and then set the version to what is stored in the variable.

There is a similar release script which would be used when an actual new APK is used, but the flow is much the same.

As for the support aspect, we use cider for managing versioning as well, so as part of that script, I simply `echo` the version number into a `version.txt` file which is read up into the app, and instead of getting the app version of `PlatformInfo`, it now comes from that text file, at least that way both Shorebird and non-Shorebird clients will still see the "correct" version.

## The correct APK

Another small thing I ran into, which was very quickly resolved by messaging them on Discord, and is actually just something missing from the docs, the release command by default builds an app bundle, which is perfect/preferred for dealing with the Play Store. Not so much when needing to distribute manually.

After contacting them I found out that `shorebird build`, while wrapping Flutter's build command, allowing me to get an APK, does not include the patch flow, so it will not get updated when patches are pushed out. 

If one needs an APK that will, you need to append `--artifact apk` to the release command. In my case, however, that was not the last of it...

### My Device Does Not Play Well With Others

For testing, my device is a Samsung A23, however, I noticed when swiping the app away, the patch was not coming through, no matter how long I left the app open or how many times I killed it. So I installed some network monitoring tools into the device and noticed that no calls were being made to `api.shorebird.dev`, which is how updates are queries.

Turns out, at last on this device, which would also be a modification Samsung made to the OS, swiping the app away, does not actually "kill" it. I was only able to get the patch to install when going into the applications setting and hitting "Force Kill".

Once again support to the rescuer, Shorebird has a [package](https://pub.dev/packages/shorebird_code_push) one can install, that allows you to trigger the update checks/downloads from within the application which would be essential for scenarios like this one.

One could either hook this up to the AppLifecycle events or perhaps attach it to a button, which was the approach I took, as the specific devices said client uses do not trigger these events #FunTimes.

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your development journey :D

Thanks for reading.

***

* [Flutter: Data Testing](https://remelehane.dev/posts/flutter-data-testing/)
* [Widget testing: Dealing with Renderflex Overflow Errors](https://remelehane.dev/posts/widget-testing-rendeflex-overflow/)