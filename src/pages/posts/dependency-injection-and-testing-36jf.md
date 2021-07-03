---
stackbit_url_path: posts/dependency-injection-and-testing-36jf
title: Dependency Injection and Testing
date: '2020-08-17T07:16:01.000Z'
excerpt: >-
  Using dependency injection can be great for simplifying your code and keeping
  it DRY, it can also s...
thumb_img_path: null
comments_count: 0
positive_reactions_count: 0
tags:
  - unittesting
  - widgettesting
  - flutterdevelopment
  - flutterappdevelopmen
canonical_url: 'https://medium.com/wyzetalk-tech/dependency-injection-and-testing-9356069706c8'
template: post
---


[![](https://cdn-images-1.medium.com/max/1000/1*w_Hwise5fi9orTgRt5ClQA.jpeg)](https://medium.com/wyzetalk-tech/dependency-injection-and-testing-9356069706c8?source=rss-3ee6df9873b3------2)

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

I hope you found this useful, and if you have any questions, comments, or improvements, feel free to drop me a comment.

Thanks for reading.

- [Widget testing passed in function](https://medium.com/wyzetalk-tech/widget-testing-passed-in-function-169c2633180b)
- [Widget testing when your app needs access to directories](https://medium.com/wyzetalk-tech/widget-testing-when-your-app-needs-access-to-directories-2c9c7aa73b8a)

> **_About Wyzetalk_**  
> Founded in South Africa and headquartered in The Netherlands, Wyzetalk is a leading global employee experience company that offers a mobile-first digital solution connecting large organisations with their dispersed, frontline workforce to improve communication, unleash innovation, and boost business performance. Since launching in 2012, the company has grown in revenue by more than 100% per annum. With a presence in 18 countries across five continents, today there are 650 000 employees making use of the Wyzetalk platform through clients in the Mining, Retail, FMCG, Manufacturing, Energy, Automotive and Shipping sectors.

> Website: [https://www.wyzetalk.com/](https://www.wyzetalk.com/)

*[This post is also available on DEV.](https://dev.to/remejuan/dependency-injection-and-testing-36jf)*


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
