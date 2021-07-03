---
title: 'Flutter Web: Should I use it? (Part 2 — Performance)'
stackbit_url_path: posts/flutter-web-should-i-use-it-part-2
date: '2021-06-27T14:35:35.000Z'
excerpt: >-
  Many times online the question has been asked “Is flutter good for web”, and what many developers fail to truly understand is that is a very broad and open question and there are many factors that go into saying yes, no or maybe.
tags:
  - seo
  - flutterdevelopment
  - flutter
  - flutterwebdeployment
template: post
---

## Flutter Web: Should I use it? (Part 2— Performance)

![Post header image](https://cdn-images-1.medium.com/max/4800/1*DTmKsPfjSR-mjw7sqeVwyQ.jpeg)

I hope you enjoyed the first part of this series where I covered SEO and Web Scrappers and their bearing on using Flutter for Web, if you have not read it yet, it is definitely worth checking out first.

[**Flutter Web: Should I use it? (Part 1 — SEO)**](https://dev.to/remejuan/flutter-web-should-i-use-it-part-1-seo-271k)

In this part, we go into one of the other big SEO factors, performance, while search engines are scraping the text content of your website in order to be able to analyze and categorize what it may be about for later use when a user searches, they are also paying close attention to the performance of your website.

Performance is measured in a few ways, of the more important ones to consider and probably the easiest ones we as developers can solve or at least mitigate is download time and time to first meaningful paint.

### Download Time…

Download time should be pretty obvious, but that is how long it takes for your website to finish downloading to the user's browser or in the case the search engines testing “browser”, naturally faster is better, and ways to improve would be to reduce the overall payload site and optimize the network request, and in some cases more is less.

A modern browser can handle numerous network requests, between tens and even hundreds so lots of small, cachable files can be more beneficial than a single bundle file, JS devs will remember the vendeor.js file.

In the case of Flutter for the web, the payload is still pretty large, after Flutter 2 was released I put together a small app to look into null-safety from a clean slate instead of upgrading an existing project.

It was very simple with a single page and a single API call built with riverpod. You can take a look [HERE](https://crypto_pricing.codemagic.app), and the [source code](https://github.com/RemeJuan/crypto_pricing).

The payload size here, for an HTML build, is about 3MB, in React it probably would have been around 400kb if not less, it would be about double the size in a canvas build that downloads a web assembly runtime of about 3MB.

### Time to first meaningful paint…

This is a measurement of how long it takes for something meaningful to the user to show up on the screen, something past the browser's default white page or your website's main background colour.

This could be text or even a loading spinner, something that indicates to the user that something is happening.

As you can imagine, this is impacted by that download speed, unless you have enough of your website downloaded, there is not much you can actually paint on the screen, in the case of Flutter, you mainly waiting for main.js to finish downloading before anything does appear in the screen.

### Analyzing Performance…

For those who have not heard of it before, one of the more common tools for measuring a site's performance is [Google’s Lighthouse](https://developers.google.com/web/tools/lighthouse/), here you can input yours, or any website address and get quite a bit of useful information as to the performance and bottlenecks within the website, this information can be very valuable in finding the best way to improve the performance of one's website.

Lighthouse will give you an analysis for both web and mobile, with mobile being one of the more important considerations these days, a far larger percentage of users spend time on websites/app from their mobile devices instead of computers.

You can take a look at the score for that small app I mentioned earlier [HERE](https://developers.google.com/speed/pagespeed/insights/?url=https%3A%2F%2Fcrypto_pricing.codemagic.app%2F&tab=mobile), as you will see the score is pretty low for mobile, and slightly better on desktop.

![Lighthouse Score (Mobile) for Crypto Pricing App.](https://cdn-images-1.medium.com/max/3848/1*7o-l3Sou38uSn-7ex1YoUw.png)

As you can see one of the first metrics the site “fails” on is *First Contentful Paint, *which only happens in at around 15s, which is probably about 13–14 seconds too slow.

Further down the page, you will see specific diagnostics pointing to specific “pain” points for the site, one of the main ones being the main.js file which right now is quite large so not only takes some time to download but also time to process.

We also need to conisder that this was run against an HTML build, flutter can be optionally built specifying either to use `canvaskit` or `html` as the rendering engine, for reasons I had to specify HTML, however by default it will effectivel ybuild with both, opting for `canvaskit `on desktop and `html`on mobile. 

This would mean that on desktop, there would be an additional 2.5 - 3mb for the `wasm` web assembly file that is needed for `canvaskit` which would have an additional cost towards download speed and First Contentful pait.

Lighthouse, is also an indicator of a users first visist, or first visit per deploy, which would pretty much be the worst case scneario, susequint visits would be substantially faster, as many, if not most, of the files would be cached on the users device so they should in effect on experience this long delay once per app deploy.

### What can we do to improve these…

For either of these factors, right now there is not too much you as the developer can do to help improve or mitigate these unless of course, you are experienced enough to be able to help the core team improving Flutter web.

For now, we simply have to wait for them to improve the compiler and maybe give us a bit more control over how the bundle is built, it is possible that if we could break the bundle up into smaller chunks and get all the essentials in a main.js and the rest of the code in chunks, we could greatly improve both the download and first meaningful paint times.

****

Next time we will go into other factors I believe, you as the developer should consider when deciding on Flutter for the web for your project.

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

* [Developing on an M1 Mac (Flutter)*](https://remelehane.dev/posts/developing-on-an-m1-mac-flutter/)
* [React to Flutter: One Developers Journey — Part 1](https://remelehane.dev/posts/react-to-flutter-one-developers-journey-part-1/)