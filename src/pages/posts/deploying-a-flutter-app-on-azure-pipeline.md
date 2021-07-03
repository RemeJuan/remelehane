---
stackbit_url_path: posts/deploying-a-flutter-app-on-azure-pipeline
title: Deploying a Flutter App on Azure Pipeline
date: '2020-05-01T02:27:00.000Z'
excerpt: >-
  Recently I decided it was time to remove the build process from my own machine, I had looked at codemagic.io, but cost wise it would not have been feasible when we already had a full azure setup for the rest of our products.
tags:
  - flutter
  - android
  - fastlane
  - ios
template: post
---


![Flutter Banner Image](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*8vESVWZfAnEeICajgWOODA.jpeg)

### Background:

Recently I decided it was time to remove the build process from my own machine, I had looked at codemagic.io, but cost wise it would not have been feasible when we already had a full azure setup for the rest of our products.

There was not too much info available online as to how to get it work, specifically iOS, and that which I did find, did not work, so just in case anyone else has a tough time, here is what I ended up doing.

To work around some of the issues I was facing, I needed to add [fastlane](https://fastlane.tools/) into the pipeline, which was how I had been doing the deployments up until now.

Using the available tooling for getting iOS built was not easy to figure out at all and in the end I was never able to work out how to resolve the last (I presume) issue with signing the archive.

The android tool worked, only issue I had was that it could only build for a single architecture, and I was not using aab for this project, and building a standalone 32b apk resulted in upload failures as it did not pass 64b requirements.

The android tools worked right off the bat, but for me a big limitation was the inability to build multiple apk’s( — split-per-abi) and at this stage moving over to aab is not an option. This meant I was only able to push up the 64 bit apk as the 32 bit naturally failed the 64 bit check.

### The Steps:

For a quick overview, which covers purely the pipeline here is my yaml file, however a few other code changes where made as well to facilitate these steps.


<iframe class="liquidTag" src="https://dev.to/embed/gist?args=https%3A%2F%2Fgist.github.com%2FRemeJuan%2Fd5bfaf9fc59a666527f519cd4b0266ed" style="border: 0; width: 100%;"></iframe>


The first step was simply to install [fastlane](https://fastlane.tools/), which was done using the command-line tool:


```
brew install fastlane
```


I also had to ensure the gem bundler was correctly setup, I included this in a separate command-line script which makes it easier when debugging output.


```
gem install bundler

bundle update --bundler

bundle install
```


On the code side I added a new lane\* to fastlane to ensure the provisioning profiles where there and up-to-date. Using a white-label app we use a profile per pipeline/client as it’s easier to manage, especially for the few that use their own store accounts. Fastlane is also capable of generating these for you from the command-line

> \*a lane is basically command line script group


```
desc "Update provisioning profile"
 lane :profile do
 update\_project\_provisioning(
  xcodeproj: "Runner.xcodeproj",
  profile: "./provisioning\_profiles/FILE\_NAME.mobileprovision",
  build\_configuration: "Release",
 )
  end
```


These few steps use the built in tooling which may need to be installed from the market place.

**Install provisioning profile** (as from previous step)  
**Install the Apple Developer Certificate  
Install Flutter  
Flutter Build**  (iOS)

This was where I had my most issues with the tooling, I could not workout how to get XCode to generate the archive (ipa) so for that I used [fastlane](https://fastlane.tools/).


```
bundle exec fastlane ios ci
```


Which is another lane I added to [fastlane](https://fastlane.tools/), pretty much the default [fastlane](https://fastlane.tools/) setup without the push to test flight step:


```
build\_app(
    workspace: "Runner.xcworkspace",
    scheme: "Runner",
    output\_directory: "../build",
    output\_name: "app.ipa",
    clean: true,
)
```


The App Store release tooling however works great and requires less config than I would have needed with [fastlane](https://fastlane.tools/).

I also used [fastlane](https://fastlane.tools/) to build the android apk’s, this way I could build all architectures, which is 3 in my case, with a single command.


```
$(FlutterToolPath)/flutter build apk --split-per-abi --build-number=$(buildNumber) --build-name=$(package.version)
```


Finally, using the **Google Play — Release** tool I simply provided the primary apk path as the 64bit one and under advanced options you can pass a path $(Build.SourcesDirectory)/build/app/outputs/apk/release/\*.apk so that you can then push all 2 or 3 files generated files.

If you are however using aab you can simply build that with the available tools.

### Conclusion:

I hope if you have made it this far you found it useful, the android steps are pretty strait forward, using [fastlane](https://fastlane.tools/) there is more of a “me” requirement other than something I think will generally be used, it is advisable to use the aab rather, but managing multiple apps for multiple clients I feel may be unnecessarily complicate the process especially seeing as we will need to update existing apps.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.
