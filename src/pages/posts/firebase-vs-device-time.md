---
stackbit_url_path: posts/firebase-vs-device-time
title: "Firebase vs Device Time"
date: '2023-09-10T09:00:00.000Z'
excerpt: Solving incorrect timestamps as a result of incorrect device time
tags:
  - Shorebird
  - Flutter
  - FlutterDevelopment
  - AppDeployment
template: post
thumb_img_path: https://cdn.hashnode.com/res/hashnode/image/upload/v1696691981119/4e48b387-9962-44f0-bd78-9223d85ec9d4.png?w=1600&h=840&fit=crop&crop=entropy&auto=compress,format&format=webp
---

![Github CoPilot](https://cdn.hashnode.com/res/hashnode/image/upload/v1696691981119/4e48b387-9962-44f0-bd78-9223d85ec9d4.png?w=1600&h=840&fit=crop&crop=entropy&auto=compress,format&format=webp)

One of my favourite things about development is solving problems, and I am not one for accepting there is no solution, this one definitely required some more creativity when it came to solving it.

## Backstory

With an application that is used in many various areas, we like to maintain high level of offline capability with the application, as this helps to keep things running smoothly when there is low or no mobile reception.

Like many others, to aid with this we also make use of Firebase, while it has it's flaws, it does do a great job of managing data transfer when the network conditions are poor to terrible, and the data does always eventually arrive.

Recently an edge case was brought to our attention, the data that was being pushed directly to Firebase was arriving with incorrect timestamps, as many of these where out by 1-2 hours our initial assumption was timezone, which should be something quite simple to deal with...

Unfortunately not so simple, Firebase does deal with timezones perfectly fine, and as it turns out the issue was in fact these particular users had actually set their clocks manually, and incorrectly, and why would Firebase assume the source of truth to be wrong.

## The not so good ideas.

While it probably should have been obvious that this idea was too simple to simply work, I was had not yet realised the timezone was not the issue, so as we use an extension on `DateTime`, which proving to be handy for this scenario was initially introduced to allow `DateTime` mocking within unit tests.

```dart
extension ExtendedDateTime on DateTime {
  static DateTime? _customTime;

  static DateTime get current => return _customTime ?? DateTime.now();

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }
}
```

So I opened up the extensions files, added `.toUTC()` and, well that was not it...

This is when I began really digging into the issue and messing with my test devices time, this is when I realised that timezone was unrelated to the issue and as long as the time was correct, the time zone made no difference.

If I were lucky, this would have been something easily fixed with Firebase's on utility, `FieldValue.serverTimestamp()`, however, the data in question is part an array, which is most simply updated by using `FieldValue.arrayUnion([])`. This however does not support `serverTimeStamp` which only works when part of the top level `set` or `update` methods.

Next idea was to try out the [timezone](https://pub.dev/packages/timezone) package, however this is subject to the same rules of logic and as long as the clock is wrong, so is it.

## Just crazy enough to work?

This was one of those times when I took to my living, breathing "rubber duck", aka my dog, and while I never try explaining my code to her, I often find solutions find there way to me while taking her for a walk, this was one of those cases.

Another package we have for Flutter is the [ntp](https://pub.dev/packages/ntp) package, which allows us to get the "real" time from a Network Time Protocol server, so a source of truth not bound to the users device

So while this is naturally an online call, we do not make it whenever we are needing the time, other then being inefficient and a waste of data, it would fail under the worst of conditions.

No, this call is made quite infrequently, at initial app launch and AppResume, and is small enough to be more resilient to poor network conditions.

Making use of a global variable, I store the difference between NTP time and Device time, which when the clock is correct is only a few milliseconds.

```dart
  static Future<void> setTimeGap() async {
    final startDate = await NTP.now();
    final phoneNow = DateTime.now();
    final diff = startDate.difference(phoneNow);

    ClockDifference = diff;
  }
```

Above you will see the simple function written to get this, starting with getting the network time, then the device time and finally storing it on the global `ClockDifference` variable.

This leads me to a small update on the extension shown earlier:

```dart
  static DateTime get current {
    final diff = ClockDifference;
    final now = DateTime.now();

    if (diff.isNegative) {
      return now.subtract(diff.abs());
    } else if (!diff.isNegative && diff != Duration.zero) {
      return now.add(diff);
    }

    return _customTime ?? now;
  }
```

Using that we check if that difference is negative so we know which way to adjust the time, and for the benefit of testing, or the call having failed we also ensure the difference is not `Duration.zero` which is also the default value for the global.

While a solution not without its caveats, this is an edge case as mentioned and for the vast majority of our users this will not really be required, however as some of these timestamps find there way into reports and some of those can form part of financial calculations, its safer if the data is potentially off by a rounding error than a number of hours.

Time is after all money...

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your development journey :D

Thanks for reading.

***

* [Flutter: Data Testing](https://remelehane.dev/posts/flutter-data-testing/)
* [Widget testing: Dealing with Renderflex Overflow Errors](https://remelehane.dev/posts/widget-testing-rendeflex-overflow/)
