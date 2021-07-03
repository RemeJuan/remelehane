---
stackbit_url_path: posts/unit-testing-a-utility-function-that-returns-a-widget
title: Unit Testing a Utility function that returns a Widget
date: '2021-03-31T11:22:38.000Z'
excerpt: >-
  Probably not too common a use case, but for me I have a utility function for
  handling in-app naviga...
tags:
  - flutter
  - unittesting
  - flutterappdevelopmen
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*dqggYKcf6EZ3T2E9dRAL8A.jpeg
---


![Flutter Logo](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*dqggYKcf6EZ3T2E9dRAL8A.jpeg)

Probably not too common a use case, but for me I have a utility function for handling in-app navigation from the in-app web view webview\_flutter while it does have a generic error handler, I need to be handle errors differently based on what type of URL was selected as custom logic is required to be able to handle links that are not actually valid.

A snippet from the utility mentioned above:


<iframe class="liquidTag" src="https://dev.to/embed/gist?args=https%3A%2F%2Fgist.github.com%2FRemeJuan%2Fdc09ef02c6fe4301b59de866854b5a0d" style="border: 0; width: 100%;"></iframe>


In this case, groups is a URL path that we currently do not support within the flutter app, so there is other logic specifically for groups, but for brevitiy we will reference the generic \_handleUnsupported function which returns a Snacbar with a localized error message.

Normally with a utility test, one would simply use expect, however in this case the functions result would be a visual element, so before we can expect anything, we need to setup a test to allow all the logic to run.


<iframe class="liquidTag" src="https://dev.to/embed/gist?args=https%3A%2F%2Fgist.github.com%2FRemeJuan%2Fbde3586378ec02935b10bc54623b2833" style="border: 0; width: 100%;"></iframe>


There are actually quite a few things happening here in this test, but the most important part is the setup on line 13. Here we are setting up a test implementation of the widget, the provideLocalizedWidgetForTesting is a test utility I setup, you can read about it [HERE](https://dev.to/remejuan/bringing-localization-into-your-widget-testing-71f).

As the resulting Snackbar also makes use of context fot state access as well as localization I have included the LayoutBuilder to get hold of the context from the test utility.

The utility function itself is a Future and one of the easisest way to run those inside a widdget is with the FutureBuilder, which links back up to the future function on line 8. Here is simply included a short delay to help manage ui rendering within the test context, otherwise you end up with it failing as needsBuild get’s called.

So once we have settled and pumped that additional second, we are now able to expect the Widget that should be rendered on the screen.

As mentioned above, not a very common usecase, and when possible one should always keep UI and Utilities seperate, and after having written this I had found a better way to deal with it in my use case, a way that did not involve returning a widget from a utility.

I felt however the learning itself was still valuable, and the possibility does exist that this is an unavoidable scenario for someone, or even myself at a later stage. # SharingIsCaring

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

If you wish to carry on with the subject of testing, why not take a look at:

- [Widget testing passed in function](https://remelehane.dev/posts/widget-testing-passed-in-function/)
- [Widget testing when your app needs access to directories.](https://remelehane.dev/posts/widget-testing-when-your-app-needs-access-to-directories/)
