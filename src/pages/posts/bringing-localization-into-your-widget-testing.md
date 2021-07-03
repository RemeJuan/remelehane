---
stackbit_url_path: posts/bringing-localization-into-your-widget-testing
title: Bringing localization into your Widget testing
date: '2020-07-20T07:16:01.000Z'
excerpt: >-
  The more accurate you make your test, the higher the quality of the test itself.
tags:
  - widgettesting
  - unittesting
  - flutter
  - mockito
template: post
---

![](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*KcSljL8cBi93F7WyFYOYQg.jpeg)

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

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

[Widget testing passed in function](https://remelehane.dev/posts/widget-testing-passed-in-function-kpi/)
