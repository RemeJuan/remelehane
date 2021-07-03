---
stackbit_url_path: posts/adding-flutter-web-to-an-existing-application
title: Adding Flutter web to an existing application
date: '2020-08-03T07:16:00.000Z'
excerpt: >-
  As it stands now flutter web is not ready for production use, to get started however they have prov...
tags:
  - flutter
  - flutterweb
  - fluttermobile
  - flutterdevelopment
template: post
---

![](https://cdn-images-1.medium.com/max/1024/1*1orxIbVfgZa4mB_qEL17Yg.jpeg)

As it stands now flutter web is not ready for production use, to get started however they have provided the required steps at the [Flutter Docs](https://flutter.dev/web).

One thing os note is, and possibly the biggest hindrance in more mature codebase would be the fact that dart:io does not yet support web and you would need to be using dart:html.

There is a way to do this though, as dart does support conditional imports, but the size of your codebase is going to impact the level of refactoring that needs to be done in order to achieve this.

For starters, you would no longer be able to directly reference dart:io in your codebase. You would then not be able to use HttpClient you would need to use [Dio](https://pub.dev/packages/dio) or http from http/http.dart.

To control the “switch” between mobile and web you can create a delegation service, a set of files you can then use to define the methods you need to use that are available form both dart:io and dart:html.

You are going to need to create 4 files, I called them: platform\_delegate\_main.dart, platform\_delegate\_web.dart, platform\_delegate\_mobile.dart and plaform\_delegate.dart.

In this example, I am going to use a helper that I used to wrap Platforms so that I could maintain the testability of functions that needed access to platforms.

I have an abstract class SupportedPlatforms:


```dart
abstract class SupportedPlatforms {
 bool isAndroid();
 bool isIos();
}
```


The platform\_delegate.dart simply handles the export and the conditions for which platform you are using.


```dart
// The export file
// platform\_delegate.dart

export 'platform\_delegate\_main.dart'
  if (dart.library.js) 'platform\_delegate\_main\_web.dart'
  if (dart.library.io) 'platform\_delegate\_main\_mobile.dart';
```


Each file then needs to contain the same methods/classes.


```dart
// platform\_delegate\_main.dart
import 'supported\_platform\_helpers';

class SupportedPlatformsImp implements SupportedPlatforms {
   @override
   bool isAndroid() => false;
   @override
   bool isIos() => false;
}

// platform\_delegate\_main\_web.dart
import 'dart:html' as html;
import 'supported\_platform\_helpers';

class SupportedPlatformsImp implements SupportedPlatforms {
   @override
   bool isAndroid() => false;
   @override
   bool isIos() => false;
}

//platform\_delegate\_main\_mobile.dart
import 'dart:io' as io;
import 'supported\_platform\_helpers';

class SupportedPlatformsImp implements SupportedPlatforms {
   @override
   bool isAndroid() => Platform.isAndroid;
   @override
   bool isIos() => Platform.isIOS;
}
```


When using functions you could either return an acceptable default or throw an UnsupprtedError.


```dart
void myFunction() => throw UnsupportedError('myFunction is Unsupported')
```


Then at implementation time, you will be importing platfomr\_delegate.dart


```dart
import 'platform\_delegate.dart';

void main() {
  if (SupportedPlatform().isIos()) {
    // Do stuff for apple...
  }
}
```


Here I can still maintain platform-specific conditions while supporting web and mobile, as on Android or Web isIOS() will safely return false and we are no longer worried about dart:io preventing flutter web from functioning.

I hope you found this useful, and if you have any questions, comments, or improvements, feel free to drop me a comment.

Thanks for reading.

- [Wyzetalk Tech](https://medium.com/wyzetalk-tech)
- [Widget testing passed in function](https://dev.to/remejuan/widget-testing-passed-in-function-kpi)

* * *

*[This post is also available on DEV.](https://dev.to/remejuan/adding-flutter-web-to-an-existing-application-4da9)*


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
