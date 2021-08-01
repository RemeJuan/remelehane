---
stackbit_url_path: posts/unit-testing-dattimenow-with-the-help-of-dart-extensions
title: "Unit testing DateTime.now() with the help of Dart extensions"
date: '2021-07-18T09:00:00.000Z'
excerpt: >-
  A quick guide on how we can use Darts extension methods to easily be able to test DateTIme.now();
tags:
  - flutter
  - flutterdevelopment
  - flutterweb
  - fluttertest
  - unit-testing
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*vih036gD7fwgfj2jXHgKHA.png
---
![](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*vih036gD7fwgfj2jXHgKHA.png)

## The Problem…

Often times within our applications, both on the UI and Data sides we will need to set “defaults” for dates, the simplest way to do that in most cases would be to use DateTime.now(), after all, we are most likely going to use the current time as the default value.

While this is very handy, it can create complications when it comes time to test. Within Dart it is not possible to simply override methods or functions globally, you can only mock arguments that are passed into classes, and adding an argument of DateTime to a class while easy enough, but not seldom wanted and can more then likely just lead to unnecessary bloat.

With widgets, however, that is a completely different story, you would either need to pass DateTime into the widget or create a custom class and add that to some dependency injection in order to be able to mock it in the test.

## A Solution…

One solution I discovered, which is made possible with extensions which was introduced in dart 2.7

>  Extension methods, introduced in Dart 2.7, are a way to add functionality to existing libraries. ([Link](https://dart.dev/guides/language/extension-methods))

Using this, we are able to create an extension on DateTime with which we can both get the “current” time as well as implement a setter to allow us to override that “current” time.

```dart
extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }
}
```

We have a nullable DateTime which when we use ExtendedDateTime.current within our code will return the value of DateTime.now().

That in itself is nothing special, the set method is what we really care about.

Take the following class as an example.

```dart
class User {
  final String userName;
  final DateTime createdDate;
  
  User(this.userName, this.createdDate);
  
  static User createUser(String userName) => User(userName, DateTime.now());
}
```

From within the logic of our code, we wish to create a new user, so I wish to verify that when I call User.createUser that it returns a new user with the name passed in as well as the current DateTime. However, during the execution of the test, a few milliseconds would pass between calling the function and verifying the expectation.

```dart
final result = User.createUser('Reme');
expect(result, equals(User('Reme', DateTime.now());
```

The above example is almost certain to fail as a result of those few milliseconds.

Now that we have added our extension to our project we can refactor our code to rather look like:

```dart
class User {
  final String userName;
  final DateTime createdDate;
  
  User(this.userName, this.createdDate);
  
  static User createUser(String userName) => User(userName, ExtendedDateTime.current);
}
```

After which our test would look something like:

```dart
ExtendedDateTime.current = DateTime.parse(
  "2020-05-15 13:07:53.531Z",
);

final result = User.createUser('Reme');

expect(result, equals(User('Reme', "2020-05-15 13:07:53.531Z");
```

## Final thoughts…

As you can see, with a very small change to our code, we are now very easily able to keep things simple, without impacting our ability to test them.

I often like to say, maybe it was said to me once, cannot remember…

> Working code != testable code, but testable code == working code.

It may not always be fun, but a few minutes of testing today can save you hours of debugging tomorrow.

***

I hope you enjoyed this post, if you have any questions, comments, or suggestions, feel free to drop a comment.

If you liked it, a heart would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

___

* [Flutter Web: Should I Use It](https://blog.remelehane.dev/series/flutter-web)
* [Developing on an M1 Mac (Flutter)](https://blog.remelehane.dev/developing-on-an-m1-mac-flutter-563c8dcc28f)
