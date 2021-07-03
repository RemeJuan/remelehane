---
stackbit_url_path: posts/flutter-using-self-signed-ssl-certificates-in-development-20ce
title: 'Flutter: Using Self Signed SSL Certificates in Development'
date: '2019-07-06T17:43:20.000Z'
excerpt: >-
  I recently started working with Flutter during an RnD phase at work after
  Ionic which had been the...
thumb_img_path: null
comments_count: 1
positive_reactions_count: 33
tags:
  - flutterdevelopment
  - development
  - sslcertificate
  - flutter
canonical_url: >-
  https://medium.com/@reme.lehane/flutter-using-self-signed-ssl-certificates-in-development-c3fe2d104acf
template: post
---


![](https://cdn-images-1.medium.com/max/1024/1*73IgUxPfyXUKZAaIXgutrw.png)

I recently started working with Flutter during an RnD phase at work after Ionic which had been the planned direction revealed itself to be a non-viable option given the businesses requirement. Personally, probably professionally and potentially even for the business, that was a blessing in disguise.

That problem introduced us all to flutter, and I myself was very happy with the discover, it was easy to use, tutorial were abundant and coming from a Typescript Front-end environment it was both different and familiar.

It’s early days still, but so far I have only run into 1 significant problem working with it, and that was when trying to connect to my local api, which naturally has a self signed cert. Getting around this, or more accurately working with this seemed far more complicated than I would have expected.

While many results to come through on google, unfortunately for someone 4 days into Flutter, none of the answers gave enough context for me to understand what I needed to do, many hours later and lots of reading I began to discover the context through the various code bits and posts that I read through.

> This is simply the documentation of that in the hopes that the next new guy find it and gets a complete picture that is hopefully a lot easier to understand.

As Far as my Google Fu indicated, only 2 packages that I could find had support for working with **bad** certificates, and that is [HttpCllient](https://api.dartlang.org/stable/2.4.0/dart-io/HttpClient-class.html) and [Dio](https://github.com/flutterchina/dio), I had mostly worked out my own solution by the time I got to Dio, so the following code is for HttpClient.

HttpClient has a method called _badCertificateCallback_, I had written a class for managing cookies for all my API calls which contains, for now, my GET and POST.


```
static HttpClient client = new HttpClient()
    ..badCertificateCallback = (\_certificateCheck);
```


So when instantiating the HttpClient class, I instantiated it with the _badCertificateCallback_ which is a function, which I wrote as:


```
static bool \_certificateCheck(X509Certificate cert, String host, int port) => host == 'local.domain.ext';
```


The function itself is simply expecting a bool, many of the posts I found simply suggested having it return true, but thats unsafe, even if this were left in and made it to production, it poses a very low risk.

In simple terms this is what you need to do to get your Self Signed Cert working withing your dev environment, now to ensure complete context and maybe glean a few extra ideas, here is the current version of the Class I am using:


<iframe class="liquidTag" src="https://dev.to/embed/gist?args=https%3A%2F%2Fgist.github.com%2FRemeJuan%2F3ab63fc2adc948e0804b63f4f3b4244f" style="border: 0; width: 100%;"></iframe>


I have both the GET and POST, with helpers for dealing with Cookies using [Cookie\_Jar](https://github.com/flutterchina/cookie_jar), so for each request I am updating CJ with any cookies coming down from the API which are then attached to any subsequent calls.

I have not fully tested the cookie side of this Class yet, I will update the Gist if any changes are made.

Thanks for reading, I hope you have found this useful/informative. Drop me a comment if you have any questions or suggestions/improvements, we are all always learning. Don’t forget the clap, and share if you think someone else may benefit from it.

*[This post is also available on DEV.](https://dev.to/remejuan/flutter-using-self-signed-ssl-certificates-in-development-20ce)*


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
