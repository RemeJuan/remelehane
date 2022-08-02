---
stackbit_url_path: posts/weekend-app-3d-print-cost-calculator
title: "Weekend App: 3D Print Cost Calculator"
date: '2021-12-28T09:00:00.000Z'
excerpt: A small app I built to solve a really simply problem I had, while testing form_bloc and VG CLI
tags:
  - flutter
  - flutterweb
  - fluttermobile
  - flutterdevelopment
  - 3dprinting
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/play_store_feature.webp
---
![Banner image](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/play_store_feature.webp)

A 3D Printer has been on my shopping/wishlist for some time, and this Black Friday a very nice one came up for a very good price, I had always assumed that the running costs of such a thing were relatively high, quite happy to say I was very wrong on that one.

After a few weeks or mostly thumbsucking how much things cost I took to DuckDuckGo to see what calculators existed, and while there are quite a few, they were either very simple or overly complicated for my "for funzies" use case.

I was not running a business, so cleaning and polishing times were not factors, other staff did not exist, so the complex ones were a non-starter really and the simple ones to me did not give the whole picture, sure the filament in most cases is the bulk of the cost, but electricity is also a factor and I like full pictures.

To solve this "problem" I wrote a really simple app, initially, I was going to just spin up a spreadsheet, but those suck to use on a phone.

Spinning up an app also gave me the chance to play with more recent developments in the Flutter community.

The  [Very Good Venture CLI](https://verygood.ventures/blog/flutter-starter-app-very-good-core-cli)  has been floating around my Twitter feed for some time, so when bootstrapping this App I went with that, and I must say I really do like the boilerplate they provide. It ships with BLoC as well as the VGV linting config as well as a nice GH Action script.

With that, I also added in  [form_bloc](https://pub.dev/packages/form_bloc), which, considering the size of the app was complete overkill, but oftentimes trying out new things can be a lot easier in a very small and specific use case. With that, I was also quite impressed, forms in general suck and this does simplify it while also providing a few useful extras.

![3D Print Cost Calculator Screenshot](https://cdn.hashnode.com/res/hashnode/image/upload/v1640682660736/cGaNRXk0O.png)

As mentioned, the app is really simple, it is just one screen and I had only planned on having it as a PWA, but after a day or so, seeing as I already had a developer account with Google, I figured why not...

You just scrolled past the screenshot, and that quite literally is all there is to it, the 6 input field and the result underneath, that is actually the 3rd "update". The initial version had all the inputs with a "calculate" button, which then revealed the results.

After that, I decided to make my life easier and add in [sembast](https://pub.dev/packages/sembast) which I really wish I had found sooner for another project, but anyway. This seemed about the easiest way to store data long term for the web so I persisted the top 4 fields, Printer Wattage, Electricity Cost, Filament weight and cost as those 4 are the least likely to change between calculations.

The last 2 will always need to be filled out, but the last/most recent update was to actually remove the calculate button and just run the math as the values are completed.

___

I still need to spend some time working on the testing, have not quite figured out how to correctly test form_bloc and I just need to sit down and do the widget testing, while this app is simple enough to arguably not need extensive testing, I quite enjoy the testing and it's the small simple things that can sometimes teach you the most.

The problem you run into in the tiny 1-page app, could and will likely also crop up in the big 12k+ LOC project, and it's probably not going to be easier to solve in that one...

___

For those interested, here are all the relevant links, you can play around with the app and even dig around what very little code there is...

[Repo](https://github.com/RemeJuan/threed_print_cost_calculator) | [PWA](http://printcalc.codemagic.app) | [Android App](https://bit.ly/3DPrintCalc)

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

***

* [Automated Unit Testing with GitHub Actions](https://remelehane.dev/posts/automated-unit-testing-with-github-actions/)
* [Learning, by solving a “problem”](https://remelehane.dev/posts/learning-by-solving-a-problem/)
