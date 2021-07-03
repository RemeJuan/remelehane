---
stackbit_url_path: posts/bringing-localization-into-your-widget-testing-71f
title: Bringing localization into your Widget testing
date: '2020-07-20T07:16:01.000Z'
excerpt: >-
  The more accurate you make your test, the higher the quality of the test
  itself.  Many apps these d...
thumb_img_path: null
comments_count: 1
positive_reactions_count: 6
tags:
  - widgettesting
  - unittesting
  - flutter
  - mockito
canonical_url: >-
  https://medium.com/wyzetalk-tech/bringing-localization-into-your-widget-testing-121ef7eec7c
template: post
---


![](https://cdn-images-1.medium.com/max/1024/1*KcSljL8cBi93F7WyFYOYQg.jpeg)

The more accurate you make your test, the higher the quality of the test itself.

Many apps these days are built to be more accessible, one thing we do to ensure this is we localize our applications, allowing people who do not speak the same language as we do, to also use the application.

In our application, we have been using [easy\_localization](https://pub.dev/packages/easy_localization), I know there are quite a few choices, but for us, this was one of the easier ones to implement and for us, the JSON support was a big win with how we manage our localization.

To ensure we have the most accurate widget tests, we rather use “real” localizations than having to mock the helper classes.

To do this we keep a local copy of the locale JSON files to keep them safe from external updates and have created a helper function createLocalizedWidgetFortesting which looks like:


```dart
Widget createLocalizedWidgetForTesting({Widget child}) {
  return EasyLocalization(
    path: '$TEST\_MOCK\_STORAGE/locale',
    useOnlyLangCode: true,
    assetLoader: FileAssetLoader(),
    fallbackLocale: const Locale('en'),
    supportedLocales: globals.supportedLocale,
    saveLocale: false,
    child: MaterialApp(
      home: Scaffold(
        body: child,
      ),
    ),
  );
}
```


As you will see, EasyLocatlizationrequires a path, that is simply a constant that we have defined a little higher in the file, as it is used as part of other mocks.


```dart
const TEST\_MOCK\_STORAGE = './test/fixtures/core';
```


Beyond that, everything else is pretty much how it is set up in main.dart.

Here is a simplified example of how a test would look with this implementation.


```dart
void main() {
  testWidgets(
    'Should render localized widget',
    (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createLocalizedWidgetForTesting(
          child: SampleWidget(),
        ),
      );

      await tester.pumpAndSettle();

      // expectations to follow
    }
  );
}
```


Through this would be able to run proper expectations like:


```dart
expect(find.text("Sample localized text", findsOneWidget);
```


More importantly, if you have a language switcher that a user can select you can test for text changes through a setup flow.

I hope you found this useful if you want to learn more about flutter testing why not take a look at some of the other posts we have written…

[Widget testing passed in function](https://dev.to/remejuan/widget-testing-passed-in-function-kpi)

* * *

*[This post is also available on DEV.](https://dev.to/remejuan/bringing-localization-into-your-widget-testing-71f)*


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
