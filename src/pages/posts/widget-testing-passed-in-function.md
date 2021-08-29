---
stackbit_url_path: posts/widget-testing-passed-in-function
title: Widget testing passed in function
date: '2020-07-10T10:31:23.000Z'
excerpt: >-
  In this post, we going to go through how, at least in my opinion, one would go
tags:

  - mockito
  - widgettesting
  - flutter
  - unittesting
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*4ezoav544ciIcSAa67ci1w.png
  about testing that a...
---


![Mokito logo image](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*4ezoav544ciIcSAa67ci1w.png)

In this post, we going to go through how, at least in my opinion, one would go about testing that a function is called within a widget when that function is one of the Widgets arguments.

Take the following overly simplified example…


```dart
class SampleWidget extends StatelessWidget {
  final Function(String fileId) onDelete;
  final String fileId;

  const SampleWidget({
    @required this.onDelete,
    @required this.fileId,
    foundation.Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw FlatButton(
      onPressed: () => onDelete(fileId),
      child: const Text('Delete'),
    );
  }
}
```


As you can see we have a simple “reusable” widget that takes a 
`fileId`
 and a 
`onDelete`
 function.

Testing this in the implementing widget is quite simple as you would simply verify the resulting function is called.

However, if you wished to test this widget in isolation, there are a few more steps required.

In our current project, we added a very simple helper class:


```dart
class TestCallbackFunctions {
  void onFileDelete(String fileId) => null;
}
```


This class will then hold simply “mock” functions that we can pass into reusable widgets to test it completely.

* * *

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

