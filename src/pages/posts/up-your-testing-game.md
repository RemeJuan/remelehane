---
stackbit_url_path: posts/up-your-testing-game
title: Up your testing game
published: false
date: '2022-04-10T09:00:00.000Z'
excerpt: >-
tags:
  - flutter
  - flutterweb
  - fluttermobile
  - flutterdevelopment
template: post
thumb_img_path: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/04/upgit_20220406_1649227494.png
cover_image: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/04/upgit_20220406_1649227494.png
canonical_url: https://remelehane.dev/posts/up-your-testing-game
---

Today we going to look at a great utility provided by Flutter's testing framework which gives us a lot more power when it comes to accurately testing our widgets.

Very often widgets can very simply be tested using `find.byType`, `find.text` and `find.byKey`. Each of these are quite simple to use, and which you choose will depend on what exactly you are trying to test for, however there are some scenarios where the basic tests like this will not yield valuable results.

Take the following widget as an example:

```dart
class SampleWidget extends StatelessWidget {
  final bool complete;
  
  const SampleWidget({required this.complete, Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return complete
        ? Icon(Icons.check_circle, color: AppTheme.strongBlue)
        : Icon(Icons.circle_outlined, color: AppTheme.strongBlue);
  }
}
```

## Simple Usecase (Icon)

Personally I do not usually test all my widgets, the above would be a sample of a very simple use-case that would make me consider writing the test, while it is extremely basic, this widget itself does poses some logic, there is a decision being made within this widget and while it's nothing complicated it serves the purpose of illustrating an ideal scenario for the test.

In the above widget there is no text I can look for, I have not supplied any Keys for the individual icons and they are both icons, so using their type would not yied in an accurate test.

If I were to write the test like:

```dart
    testWidgets('Should render the check_circile_icon', (tester) async {
      await tester.pumpApp(const SampleWidget(complete: true));
      
      await tester.pumpAndSettle();

      final iconFinder = find.byType(Icon);

      expect(iconFinder, findsOneWidget);
    });

    testWidgets('Should render the circle_outlined icon', (tester) async {
      await tester.pumpApp(const SampleWidget(complete: false));
      
      await tester.pumpAndSettle();

      final iconFinder = find.byType(Icon);

      expect(iconFinder, findsOneWidget);
    });
```

They would both certainly pass, and if one where to look at teh coverage report, that too would indicate 100% test coverage, but the test as a whole is pretty worthless, while it is running the logic, the logic is certainly working, your test in no way proves this.

If you are going to take the time to write the test (and I hoep you do), the test should always provide value beyond that of the coverage report, testing for line coverage, dilutes the value and purpose of unit testing your code.

This is where `find.byWidgetPredicate` comes in handy and will allow you to write the same test above, while being able to uniquely identify the individual icons.

`find.byWidgetPredicate` is a function based lookup that provides the widget as its function argument, this allows you to use attributes of the widget to specifically target unique instances of the same widget.

If we look at the next example, I have updated the `iconFinder` to make use of `find.byWidgetPredicate` lookup instead of the `find.byType`:

```dart
    testWidgets('Should render the circle_outlined icon', (tester) async {
      await tester.pumpApp(const SampleWidget(complete: false));
      
      await tester.pumpAndSettle();

      final iconFinder = find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == Icons.circle_outlined,
      );

      expect(textFinder, findsOneWidget);
    });
```

As you can see, within the function body we are looking for a widget that is an `Icon`(so a type comparison) and that the icon property of that Icon widget matches the `IconData` `Icons.circle_outlined`.

That way if for some reason, someone went and changed the *false* icon to `Icons.menu` for some strange reason, the `find.byWidgetPredicate` lookup would fail. If we had used the `find.byType`or even `find.byKey`, assuming we had provided unique keys, the test would have conitued to pass.

The `find.byWidgetPredicate` lookup within widget testing allows you to write near bullet proof tests.

## Better usecase (RichText)

Above was a very simple example, but within Flutter, if one wants to write a single line of text, but have a single word a phrase styled differently, be it **bold** or *italic*, we have to use the `RichText` widget along with a sequence of `TextSpan`'s in order to achieve the desired result.

Take this example:

```dart
		RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Required",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: " 70%",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      )
```

While this specific widget I probably would not actually test, it's a another great exmple for using the `find.byWidgetPredicate` in a more complicated scenario.

```dart
    final requiredScoreFinder = find.byWidgetPredicate(
      (widget) =>
          widget is RichText &&
          widget.text.toPlainText().contains("70%"),
    );
```

for the above widget, you would target it something like the above sample, as the `RichText` widget actually does break the text up into multiple parts, `find.text` will not work.

You can use `contains` to do a partial lookup or you can simply use strict equality, contains may be simpler for longer sentences.

```dart
    final requiredScoreFinder = find.byWidgetPredicate(
      (widget) =>
          widget is RichText &&
          widget.text.toPlainText() == "Results 70%",
    );
```

As you can hopefully now see, `find.byWidgetPredicate` can be a very powerful tool in your testing toolbelt and will allow you to write even better, more accurate tests.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

Wish to carry on with the topic of Unit Testing, take a look at:

- [Automated Unit Testing with GitHub Actions](https://remelehane.dev/posts/automated-unit-testing-with-github-actions/)
- [Unit testing DateTime.now() with the help of Dart extensions](https://remelehane.dev/posts/unit-testing-dattimenow-with-the-help-of-dart-extensions/)