---
stackbit_url_path: posts/changing-your-debugging-browser-for-flutter-macos
title: Changing your debugging browser for Flutter (MacOS)
date: '2021-08-01T09:00:00.000Z'
excerpt: >-
  A quick walkthrough on how to go about changing your default debugging browser to something other than Chrome on MacOs
tags:
  - flutter
  - flutterdevelopment
  - flutterweb
  - brave
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*Pg4bQMyLXDKFUryrgxQrpw.png
---
![Be Brave](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*Pg4bQMyLXDKFUryrgxQrpw.png)

By default, Flutter expects you to have Chrome installed in order to be able to develop and debug with Flutter for Web. Not all of us like or wish to use chrome, we each may have our preferred flavour of chromium, be it Brave, Opera, Vivaldi or many of the other options.

While this is specifically for changing to [Brave](https://brave.com/), the process should work the same for whichever your preferred Chromium flavour is.

All applications are installed in your applications directory, and to override the “Chrome” browser you simply need to set a new path in your environment.

This can be done by setting CHROME_EXECUTABLE in your bashrc or zshrc file, if you are using Brave, then the following should just work:

    export CHROME_EXECUTABLE = /Applications/Brave Browser.app/Contents/MacOS/Brave Browser

If you are however using a different flavour of Chromium, then the way I found the correct path was to visit the “Application Monitor”. With the browser running.

Here you would look for the running instance of the browser in the list, there may be more than one, which is normal these days as many chromium browsers isolate each tab in its own running instance for performance and security.

![Activity Monitor Screenshot](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*1YjQBN3lVqxZAnpANRAsRw.png)

You should see something similar to the above, once highlighted you want to click on the “I” icon and from the next window, click on the “Open Files and Ports” tab.

![Brave processor details screenshot](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*9mzFkahUTpL_Grcn_IE30w.png)

In the above screenshot, the line you are looking for is the 4th one:

    /Applications/Brave Browser.app/Contents/MacOS/Brave Browser

This is the path that you will be setting as the CHROME_EXECUTABLE.

Then somewhere, probably at the bottom, of the files mentioned above, you will then add:

    export CHROME_EXECUTABLE = "YOUR PATH HERE..."

Once done, load the file into your terminal or simply execute that same line within your terminal to update the environment.

To reload the file simply run:

    . ~/.zshrc
    or
    . ~/.baschrc

Then to confirm everything was successful, run flutter doctor -v and check the output, it should include something like this and the CHROME_EXECUTABLE path should be the one you set.

![Terminal screenshot showing the updated chrome path in Flutter Doctor](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*mnNBY268LRBJ_J_1Zx4XRg.png)

If like me you use the built-in tooling for your editor, you may need to restart your editor for the new environment variables to be loaded in, otherwise hitting play may continue to use Chrome.

It is also possible to run:

    flutter run -d web-server

However, at the time of writing this method did not support hot restart, so while simpler, not as useful down the line

Thank you for reading, hope you found this useful and can now use your preferred flavour of chromium to better enjoy your flutter development experience.

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

***

* [My essential tools as a Flutter Developer](https://remelehane.dev/posts/my-essential-tools-as-a-flutter-developer/)
* [Unit testing DateTime.now() with the help of Dart extensions](https://remelehane.dev/posts/unit-testing-dattimenow-with-the-help-of-dart-extensions/)
