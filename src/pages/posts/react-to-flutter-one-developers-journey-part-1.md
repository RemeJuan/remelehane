---
stackbit_url_path: posts/react-to-flutter-one-developers-journey-part-1
title: 'React to Flutter: One Developers Journey — Part 1'
date: '2021-04-26T07:32:34.000Z'
excerpt: >-
  Almost 2 years ago while working at Wyzetalk, we decided to build a [Flutter](https://flutter.dev) application, this was the beginning of my journey to a whole new world.
tags:
  - react
  - developer
  - flutterappdevelopmen
  - development
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*zYJA3LEI08WOn6E8aJ44uw.jpeg
---


### React to Flutter: One Developers Journey — Part 1

![React to Flutter: One Developers Journey Banner](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*zYJA3LEI08WOn6E8aJ44uw.jpeg)

Almost 2 years ago while working at Wyzetalk, we decided to build a [Flutter](https://flutter.dev) application, this was the beginning of my journey to a whole new world.

[Why we chose Flutter](https://remelehane.dev/posts/why-we-chose-flutter/)

I have been developing for just under 10 years, and most of that time was spent in the JavaScript world, I been through many years of frameworks starting jQuery, Backbone, AngularJS and eventually ReactJS/Native, with some dabbling around VueJS, Aurelia and some others.

For the better part of the last 5 or 6 years, I was focused on the ReactJS space, working on applications in finance, insurance and communication.

My first impression of Flutter was of some confusion really, looking at the code it felt both familiar and strange at the same time, having worked with modern JavaScript and TypeScript I was familiar with classes and typings, but everything was almost flipped around in a way.

The very first course I took as an intro Flutter was at [https://fluttercrashcourse.com](https://fluttercrashcourse.com), which proved to be a very good intro into all the basics, I think it took about 3 or so hours over a couple of days in and amongst other work.

Many mistakes were made in the early days, probably one of the bigger and harder ones to fix was not going with a globally capable state management solution, at the time I believed I could meet the business requirements by simply using the StatefulWidget, which to be honest took us pretty far, but it became clear a few months down the line, that while that was not a bad idea at the time it would prove to be a terrible one in the near future.

After about 6 months of learning with Flutter, we took a step back and took stock of what we had and what mistakes we made. The first mistake was we had no testing in place, and to be honest the codebase was the furthest thing from testable.

In comes our next big learning resource, [Reso Coder](https://www.youtube.com/channel/UCSIvrn68cUk8CS8MbtBmBkA), a very skilled Flutter developer with some excellent videos and video series on working with Flutter, one important one for us was [Flutter TDD Clean Architecture](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech), something we found a fantastic resource on structuring Flutter apps as well as writing more testable code.

From then we spent many months refactoring the app, going through all our code section by section implementing the domain-driven approach, adding in packages like [freezed](https://pub.dev/packages/freezed) to help with null-safety, adding in [pedantic](https://pub.dev/packages/pedantic) for stricter code style and structure controls, and naturally tests, lots and lots of tests.

![](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*DmIfnWoj4hgTTgH_Uo8u6w.png)

To date we have managed to get 83% of our code tested by following this approach, this has most certainly not been easy and some of our tests have ended up being either very creative or very out there.

[Unit Testing a Utility function that returns a Widget](https://remelehane.dev/posts/unit-testing-a-utility-function-that-returns-a-widget/)

At quite a few steps in the process, we have had to re-evaluate some of our package choices as unfortunately, while much of Flutters documentation is fantastic, when it comes to testing is pretty dismal and many packages don’t include any form of documentation or examples as to how to integrate them within the testing space.

This naturally made the refactor a bit more complex, [Dio](https://pub.dev/packages/dio) was one such package that we had to remove, which was a slow process as no matter how much or how far past page 3 in google I went I could not find any form of information relating to how to mock [Dio](https://pub.dev/packages/dio) in the testing space, which is quite sad given how powerful a network package it actually is.

Over this time I have written quite a few blogs around Flutter and testing, in the hopes of helping others out there who are joining Flutter or working on bigger projects and really want to get proper, quality tests in place.

While our coverage report looks nice, coverage is not everything, the coverage report is there as a sanity check, something for us as developers to use to verify whether or not the tests we have written are actually hitting all the business logic we have implemented, coverage without quality is worthless, no point having a test that does nothing but hit a line without actually properly verifying that line is working properly.

Through this journey I become somewhat active in the local Flutter communities, eventually finding myself actually presenting at a recent GDC virtual meeting, [Are You Flutter’ed Yet?](https://gdg.community.dev/events/details/google-gdg-cape-town-presents-are-you-fluttered-yet/%5C), which I actually found I enjoyed. While I may present again in the future, I will definitely be attending more of those, while the community is still small, it is a pretty great one and it was great to hear the experiences of others through their Flutter journeys.


<iframe class="liquidTag" src="https://dev.to/embed/youtube?args=oJSMT97rURs" style="border: 0; width: 100%;"></iframe>


That idea is what actually inspired this post.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

In the next one, we take a step back to the early days to take a look at one specific way Flutter really impressed up.

Stay tuned :D

***

- [Validating commit messages with dart and Lefthook](https://remelehane.dev/posts/validating-commit-messages-with-dart-and-lefthook/)
- [Improving User Experience through simple OTA updates in Flutter](https://remelehane.dev/posts/improving-user-experience-through-simple-ota-updates-in-flutter/)
