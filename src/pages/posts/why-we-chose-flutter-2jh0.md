---
stackbit_url_path: posts/why-we-chose-flutter-2jh0
title: Why we chose Flutter
date: '2020-08-24T07:16:01.000Z'
excerpt: >-
  Some would wonder why a company whos development team speaks almost
  exclusively Javascript would ch...
thumb_img_path: null
comments_count: 1
positive_reactions_count: 6
tags:
  - flutterappdevelopmen
  - mobileappdevelopment
  - hybridappdevelopment
  - flutter
canonical_url: 'https://medium.com/wyzetalk-tech/why-we-chose-flutter-fdb98fcbea8'
template: post
---


![](https://cdn-images-1.medium.com/max/1024/1*yM3feYmhF04LRjVoWFyWaQ.jpeg)

Some would wonder why a company whos development team speaks almost exclusively Javascript would choose flutter to build their next product.

Well, the short answer is, it was, and still is, the best tool for the job.

### The beginning

I was brought into [Wyzetalk](https://www.wyzetalk.com) specifically for my experience in React and React Native as that was the preferred direction for the new mobile application. I spent the first few months doing some RnD projects, and at that time I had not heard of Flutter.

After a few months, my boss was quite surprised to have me come back and say that neither React nor React native would be suitable for the project and that it would be best to use Ionic-Angular.

It was a lot more complex to set up some of the core pieces of our business logic in React Native, compared to Ionic, which I had not even worked with before. As well as an important requirement was to be able to use a single codebase for Web and Mobile.

React pretty much went out right from the get-go as we’ll make use of push notifications quite heavily and PWA’s have no support for them on iOS.

At that time we knew Ionic was planning on releasing support for React and there was another project that needed my attention, so we tabled the mobile app for about a year.

### Take 2

At this point a new member to the team has begun discussing Flutter with us, he was very impressed with it and felt it was a very good direction to go for cross-platform apps. I took another, less code-focused dive into the available tools just to see on paper how close they align with a few of the important points, at this stage Ionic-React was a strong contender.

I took a look at our main options, React Native, React, Flutter, NativeScript and Ionic-React.

React was still out as nothing had changed with regards to push-notifications.

Ionic, unfortunately, did not support Android as far back as we needed, capacitor only offered support as far back as Android 5 while a good percentage of our user base was on Android 4.4.4.

React Native support Android 4.1, which was great, however, there was still no viable solution for sharing the code on the web.

NativeScript never went very far, and while I could have given it a better shot, the fact that after installing it, I was unable to get its own demo project started following its own guide on how to do it, did not bode well to me, especially as I was already quite keen on Flutter by that point.

Flutter, while very new to me, which I think was one of the things that drew me to it, seemed very capable, the community seemed great and the code felt both strange and familiar at the same time. It provided us with far enough back Android support as well as the future ability to use the same code for web, so while probably being the riskiest choice at the time, it was also the most viable, and only one that checked all the requirements boxes.

### Today

It has been about a year since we made that decision, and it was most definitely the right one, after having worked with it for so long, made my fair share of mistakes and learned a lot, I can see why it’s gathering such a great community behind it.

We gave our UX team the spec of “_design the dream, and we will see how close we can get_”, so far we are yet to find anything we were not able to do, and for the most part without any serious complexity either.

What I found most impressive was, that being soo young and soo much younger than React Native, how vastly more stable and mature it is. I cannot imagine having been able to build what we have done so far in React Native, or at least not with some serious challenges.

Unfortunately, we are still waiting for web, and I am personally quite eager to see what it will look like, personally I am quite eager and in that regard, we are preparing the application to at least work in the beta channel so that we can get a head start on it.

[Adding Flutter web to an existing application](https://dev.to/remejuan/adding-flutter-web-to-an-existing-application-4da9)

### Conclusion

For anyone thinking of getting into Flutter, you will not be sorry, it is a great development experience, the community is substantial and growing by the day. At the time of writing the support for Android and iOS was relatively stable, Web was in Beta and Linux, Mac and Windows had all begun testing. We will soon have a truly cross-platform codebase.

I personally cannot wait to see what is next and am so glad I had the opportunity to work with this amazing technology.

Don’t get me wrong, coming from Javascript it was a very big learning curve, which helped me a lot, in the beginning, was [https://fluttercrashcourse.com/](https://fluttercrashcourse.com/), and along the way, the tutorial by Reso Coder ([YouTube](https://www.youtube.com/channel/UCSIvrn68cUk8CS8MbtBmBkA) | [Website](https://resocoder.com/)) was absolutely invaluable.

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop me a comment.

Thanks for reading.

- [Dependency Injection and Testing](https://dev.to/remejuan/dependency-injection-and-testing-36jf)
- [Unit Testing your http.MultipartRequest network method](https://medium.com/wyzetalk-tech/unit-testing-your-http-multipartrequest-network-method-fa88df725950)

> **About Wyzetalk**  
> _Founded in South Africa and headquartered in The Netherlands, Wyzetalk is a leading global employee experience company that offers a mobile-first digital solution connecting large organisations with their dispersed, frontline workforce to improve communication, unleash innovation, and boost business performance. Since launching in 2012, the company has grown in revenue by more than 100% per annum. With a presence in 18 countries across five continents, today there are 650 000 employees making use of the Wyzetalk platform through clients in the Mining, Retail, FMCG, Manufacturing, Energy, Automotive and Shipping sectors._

> _Website:_ [_https://www.wyzetalk.com/_](https://www.wyzetalk.com/)

* * *

*[This post is also available on DEV.](https://dev.to/remejuan/why-we-chose-flutter-2jh0)*


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
