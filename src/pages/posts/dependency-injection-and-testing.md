---
stackbit_url_path: posts/dependency-injection-and-testing
title: Dependency Injection and Testing
date: '2020-08-17T07:16:01.000Z'
excerpt: >-
  Using dependency injection can be great for simplifying your code and keeping it DRY, it can also s...
tags:
  - unittesting
  - widgettesting
  - flutterdevelopment
  - flutterappdevelopmen
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*w_Hwise5fi9orTgRt5ClQA.jpeg
---

![Flutter Header](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*w_Hwise5fi9orTgRt5ClQA.jpeg)

Using dependency injection can be great for simplifying your code and keeping it DRY, it can also simplify testing and even improve testability.

If you have not started using dependency injection in your app, you may want to take a look at [get_it](https://pub.dev/packages/get_it).

For those already using it, this is how you would go about testing your code that implements these injections.


```dart
class DateTimeHelpers {
 int nowInMilliseconds() => DateTime.now().millisecondsSinceEpoch;
}
```


That is a small helper I created for use within various UI’s pull-to-refresh logic to track a last updated value to ensure the spinner goes away incase the API data has not changed.

Obviously not essential to have a simple helper as part of the dependency injection but as all our BloC’s, Cubits, Use Cases, Repositories, etc already is it just keeps in line with the current code-styling.

If used in a widget, it would be accessed as:


```dart
sl<DateTimeHelpers>().nowInMilliseconds()
```


Where 
`sl`
 is assigned to G
`etIt.instance`
.

For testing, you would simply use a mocked class:


```dart
class MockDateTimeHelpers extends Mock implements DateTimeHelpers {}
```


Now if you were using this in say a bloc you would not need to also mock the dependency injection, you would simply provide the MockClass to your test BLoC, however, if you were to use this in a Widget which would be unlikely for this specific helper, you would need to add a few extra lines to your testing code.

You would need to initialize your dependencies within your test, same as you would have done in your application code.


```dart
setUp(() {
  // Setup the application services
  di.initServices();
  di.sl.allowReassignment = true;
});
```


Within your tests 
`setUp`
 method, you would initialize your dependencies and then beneath that you enable 
`allowReassignment`
. That, as the name suggests allows you to reassign your dependencies.

You can then register a new dependency using your mocked class:


```dart
mockDateTimeHelpers = MockDateTimeHelpers();

sl.registerSingleton<DateTimeHelpers>(mockDateTimeHelpers);
```


This will ensure your code runs, and if you need to control the returned value during your tests you can simply use the 
`when`
 from 
`Mokito`
 to return a value of your choosing.


```dart
when(mockDateTimeHelpers.nowInMilliseconds).thenReturn(100);
```

Then for that test or tests, depending on where you added that you can then expect that 100 to be returned whenever the Widget uses that helper.

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.
