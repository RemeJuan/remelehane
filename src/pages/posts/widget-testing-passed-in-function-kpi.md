---
stackbit_url_path: posts/widget-testing-passed-in-function-kpi
title: Widget testing passed in function
date: '2020-07-10T10:31:23.000Z'
excerpt: >-
  In this post, we going to go through how, at least in my opinion, one would go
  about testing that a...
thumb_img_path: null
comments_count: 0
positive_reactions_count: 6
tags:
  - mockito
  - widgettesting
  - flutter
  - unittesting
canonical_url: >-
  https://medium.com/wyzetalk-tech/widget-testing-passed-in-function-169c2633180b
template: post
---


![](https://cdn-images-1.medium.com/max/534/1*4ezoav544ciIcSAa67ci1w.png)

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

*[This post is also available on DEV.](https://dev.to/remejuan/widget-testing-passed-in-function-kpi)*


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
