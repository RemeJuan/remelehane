---
stackbit_url_path: posts/how-to-download-files-on-web-with-flutter
title: "Flutter Web: Should I use it? (Part 4— I believe so)"
date: '2021-07-11T09:00:42.000Z'
excerpt: "The final part of the series, let's go through suggestions on what to do when you are planning on using Flutter Web"
tags:
  - flutter
  - flutterdevelopment
  - flutterweb
  - brave
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*DTmKsPfjSR-mjw7sqeVwyQ.jpeg
---

![Post header image](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*DTmKsPfjSR-mjw7sqeVwyQ.jpeg)

This is the final part of the series, if you have not already, here is the previous one for context.

[Flutter Web: Should I use it? (Part 3— Other considerations)](https://blog.remelehane.dev/flutter-web-should-i-use-it-part-3-other-considerations)

In this part, I am going to go through some ideas and suggestions that I think will work best for those of you working on a Flutter Web project.

### Just a web project…

This one is pretty easy, as you only targeting one platform type setting up the codebase is straightforward, simply follow the documentation from [flutter.dev](https://flutter.dev/)

### Adding or targeting web with a mobile app…

This is where I think you should spend some time thinking about a cleaner way, there are significant differences between web and mobile and catering for all of that may unintentionally bloat your codebase.

If you wish to ensure that all users, both on the web and mobile, have a great experience when using your application you may want to consider a more separated project approach.

Mobile is pretty consistent when it comes to the layout, phones all generally follow the tall thin display approach so a consistent look and user experience is pretty easy.

Browsers on the other hand come in numerous resolutions, users are not always in full screen, and they may use it on phones and tablets as well so Media Queries can become quite important here, and you may also want to adjust the way certain controls or interaction happen just for a more web-like user experience.

### Setup suggestion…

While it is definitely possible and will most certainly work having both your web and mobile code sitting in the same project and folder, you may wish to actually split it up into 3 separate parts at this point.

You could consider the following layers

* Web

* Mobile

* Shared

In the Web and Mobile layers, you would implement your layout code primarily, things like Containers, Drawer, AppBar, BottomNavigation, etc.

All your UI specific Widgets, things that will be the same across Web and Mobile you would put in the Shared layer, all the custom Widget groups and possibly some complete screens could be stored there and then be shared with your Web and Mobile layers so that the components themselves, which would be reusable and configurable, can maintain their UI structure and logic while still being laid out in a way that best suits the target platform.

In addition to widgets, the shared layer could also store certain aspects of the business logic and some of the network logic, state especially is quite likely to be sharable across the layers as what you would be showing and when would remain consistent, it's the "how it looks" that we are trying to maintain a bit more control over.

Using platform delegates from within the shared layer could simplify logic sharing as well, if you consider something like file downloading, this works more seamlessly on mobile than on web, with the web requiring a little bit of creativity to achieve, which would also result in having to use web-specific code which would prevent unit testing.

I go into some details on how to setup platform delegate here: [Adding Flutter web to an existing application](https://dev.to/remejuan/adding-flutter-web-to-an-existing-application-4da9)

This allows you to still maintain an extremely reusable codebase while also having a lot more control over the specific user experience for the targeted platform.

On mobile you would more freely be able to drop it in and almost forget about it, only needing to be concerned with landscape and portrait.

For the web you can take more control over the layouts, perhaps manipulating your widgets to display in 2 columns of data side-by-side or adjust how they scale across the various breakpoints.

You would then also be able to more easily and cleanly implement top horizontal navigation for the web at the larger breakpoints and only drop back into the drawer at smaller breakpoints and not use bottom navigation, while for mobile a drawer and bottom navigation.

For that scenario, Drawer could be used as a shared widget, while Top Nav would only exist with the web side of the project and Bottom on the mobile, that way also reducing unnecessary code with the platforms.

### Things to be aware of…

So far, in my experience the code side of Web has been seamless, the only real things I would point out are:

Flutter does not define a render engine at build time, by default it will select canvas for web and HTML for mobile.

You can make the choice by appending your build command with `-web-rendered [html|canvas]`.

If you are making use of externally sourced images, as I am in the projected referenced in part one where I was getting the icons for the various cryptocurrencies from an external source, it would be simpler to for HTML as your rendering engine at build time as currently canvaskit only supports same-origin images, in order to use remote images you would first need to convert the image data to byte code and provide that to the `Image` widget.

As mentioned above, however, it is important to note that `dart:html` cannot be imported into files that are going to be unit tested, you would need to ensure that the logic for code be written within a platform delegate to ensure that the testing framework makes use of the mobile implementation.

## Conclusion

That is it from me on this series, I hope that I have given you enough detail to make a more informed decision on whether or not Flutter's Web implementation is a workable idea for your next project.

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a heart would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

* [Developing on an M1 Mac (Flutter)](https://remelehane.dev/posts/developing-on-an-m1-mac-flutter/)
* [Working from home works for me…](https://remelehane.dev/posts/working-from-home-works-for-me/)