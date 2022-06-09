---
stackbit_url_path: posts/widget-testing-when-your-app-needs-access-to-directories
title: Widget testing when your app needs access to directories.
date: '2020-07-27T07:16:01.000Z'
excerpt: >-
  Many times in an application you would have a need to store files, temporarily
tags:
  - widgettesting
  - flutter
  - unittesting
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*bnm8sRPmozmm0_tgnN97WQ.png
---


![Image of simulated mobile phones](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*bnm8sRPmozmm0_tgnN97WQ.png)

Many times in an application you would have a need to store files, temporarily or even permanently. For this, you are probably going to be using [path\_provider](https://pub.dev/packages/path_provider), however, those methods are not going to simply work when running a widget test.

Thankfully it is quite simply to be able to mock that and provide your own path for use during testing.

There is quite a simple way to do this and it is done with MethodChannel


```dart
const TEST\_MOCK\_STORAGE = './test/fixtures/core';

const channel = MethodChannel(
  'plugins.flutter.io/path\_provider',
);
channel.setMockMethodCallHandler((MethodCall methodCall) async {
  return TEST\_MOCK\_STORAGE;
});
```


You simply need to provide the channel you wish to mock, in this case, it is pluggins.flutter.io/path\_provider and use the setMockMethodCallHandler where you can either provide specific calls and values to return or in this case provide a catch-all response, in this case, what will happen is any request to path provider will return the provided path.

So whether you are getApplicationDocumentssDirectory or getExternalStorageDirectory the result is going to be ./test/fixtures/core.

An important thing to note is that this MethodChannel call needs to be run in each test that will be accessing the path, if it’s only a single test then it is fine to provide that directly inside the main().

In our case, however, there is quite a bit of the application that relies on accessing the Documents Directory. For that reason, we have added that method into a setUpTest function that we pass into the setUp((){ }) part of the widget test.


```dart
void main() {
  setUp(() async {
    await setupTest();
  });

  testWidgets(
    'Should render [SampleWidget]',
    (WidgetTester tester) async {
      await tester.pumpWidget(SampleWidget());

      await tester.pumpAndSettle();
    },
  );
}
```


If you are needing access to files, ensure they exist in the path you have provided as the mock result path, after that you should have no problems testing any Widgetsthat need access to those files.

* * *

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

