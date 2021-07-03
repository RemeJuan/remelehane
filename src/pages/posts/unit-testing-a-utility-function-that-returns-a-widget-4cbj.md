---
stackbit_url_path: posts/unit-testing-a-utility-function-that-returns-a-widget-4cbj
title: Unit Testing a Utility function that returns a Widget
date: '2021-03-31T11:22:38.000Z'
excerpt: >-
  Probably not too common a use case, but for me I have a utility function for
  handling in-app naviga...
thumb_img_path: null
comments_count: 0
positive_reactions_count: 0
tags:
  - flutter
  - unittesting
  - flutterappdevelopmen
canonical_url: >-
  https://medium.com/wyzetalk-tech/unit-testing-a-utility-function-that-returns-a-widget-77b1b3fec888
template: post
---


![](https://cdn-images-1.medium.com/max/1024/1*dqggYKcf6EZ3T2E9dRAL8A.jpeg)

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

Hope you all enjoyed the read.

If you wish to carry on with the subject of testing, why not take a look at:

- [Widget testing passed in function](https://dev.to/remejuan/widget-testing-passed-in-function-kpi)
- [Widget testing when your app needs access to directories.](https://dev.to/remejuan/widget-testing-when-your-app-needs-access-to-directories-ljd)

**_About Wyzetalk_**  
_Founded in South Africa and headquartered in The Netherlands, Wyzetalk is a leading global employee experience company that offers a mobile-first digital solution connecting large organisations with their dispersed, frontline workforce to improve communication, unleash innovation, and boost business performance. Since launching in 2012, the company has grown in revenue by more than 100% per annum. With a presence in 18 countries across five continents, today there are 650 000 employees making use of the Wyzetalk platform through clients in the Mining, Retail, FMCG, Manufacturing, Energy, Automotive and Shipping sectors._

_Website:_ [_https://www.wyzetalk.com/_](https://www.wyzetalk.com/)

* * *

*[This post is also available on DEV.](https://dev.to/remejuan/unit-testing-a-utility-function-that-returns-a-widget-4cbj)*


<script>
const parent = document.getElementsByTagName('head')[0];
const script = document.createElement('script');
script.type = 'text/javascript';
script.src = 'https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/4.1.1/iframeResizer.min.js';
script.charset = 'utf-8';
script.onload = function() {
    window.iFrameResize({}, '.liquidTag');
};
parent.appendChild(script);
</script>    
