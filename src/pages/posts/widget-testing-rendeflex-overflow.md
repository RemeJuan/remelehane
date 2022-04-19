---
stackbit_url_path: posts/widget-testing-renderflex-overflow
title: "Widget testing: Dealing with Renderflex Overflow Errors"
published: false
date: '2022-04-19T10:00:00.000Z'
excerpt: 'A simple solution to dealing with "A RenderFlex overflowed by…" in unit testing…'
tags:
  - flutter
  - flutterweb
  - fluttermobile
  - flutterdevelopment
template: post
thumb_img_path: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/04/upgit_20220419_1650356140.png
cover_image: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/04/upgit_20220419_1650356140.png
canonical_url: https://remelehane.dev/posts/widget-testing-renderflex-overflow
---

![renderflex](https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/04/upgit_20220419_1650356140.png)

We've all certainly seen it in our UI before, "A RenderFlex overflowed by...", and we all know this error means that our UI is painting beyond the bounds of our available real estate.

When this is on the screen, it's very easy to fix, but what about when you are unit testing your widgets and you run into this?

This is something I have run into a few times and for the most part, have just ignored it in tests, I condor widget testing a bit of a lower priority, for the most part, I believe their testing is best done as part of the journey or integration testing.

That being said, there are times when business logic sits within a widget, and at that point, it can be valuable to spend the time to write an adequate unit test.

In the past trying to hack around with the virtual UI has yielded some useable results, but when this error popped up more recently I went scouring around for a more reliable solution.

Full disclosure, this was mostly the brainchild of [**Remi Rousselet**](https://twitter.com/remi_rousselet), I am just helping to share it to make other developers' lives that little bit easier.

## The solution

I always keep a `test_helpers.dart` file for my unit testing, and this is my latest addition to that list of helpers:

```dart
void ignoreOverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;
  bool isUnableToLoadAsset = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
      (e) => e.value.toString().startsWith("A RenderFlex overflowed by"),
    );
    isUnableToLoadAsset = !exception.diagnostics.any(
      (e) => e.value.toString().startsWith("Unable to load asset"),
    );
  }

  // Ignore if is overflow error.
  if (ifIsOverflowError || isUnableToLoadAsset) {
    debugPrint('Ignored Error');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}
```

I have updated it somewhat from the original solution, it was written pre-null-safety and I also added in the check for errors loading local assets.

What this helper is doing is preventing the test runner from falling out when the test runs into one of these errors. I feel it quite silly that at the very least the RenderFlex issues are not an exception in tests,
Unit tests exist to test logic, how well a widget paints within a headless environment should have no bearing on the test itself.

To make use of this helper, you simply need to include it as part of your test with `FlutterError.onError = ignoreOverflowErrors;`, see the following example:

```dart
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Widget Renders Correctly', (tester) async {
    FlutterError.onError = ignoreOverflowErrors;

    await tester.pumpApp(const PrimaryHeader(child: Text('Test')));

    final titleFinder = find.text('Test');

    expect(titleFinder, findsOneWidget);
  });
}
```

For it to work, it needs to be assigned in the specific test, it cannot be assigned in `setUp` or `setUpAll`.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

Wish to carry on with the topic of Unit Testing, take a look at:

- [Flutter: Up your testing game](https://remelehane.dev/posts/up-your-testing-game/)
- [Automated Unit Testing with GitHub Actions](https://remelehane.dev/posts/automated-unit-testing-with-github-actions/)