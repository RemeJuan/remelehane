---
title: 'Flutter Web: Should I use it? (Part 1 — SEO)'
stackbit_url_path: posts/flutter-web-should-i-use-it-part-1
date: '2021-06-20T12:35:28.000Z'
excerpt: >-
  Many times online the question has been asked “Is flutter good for web”, and what many developers fail to truly understand is that is a very broad and open question and there are many factors that go into saying yes, no or maybe.
tags:
  - seo
  - flutterdevelopment
  - flutter
  - flutterwebdeployment
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*DTmKsPfjSR-mjw7sqeVwyQ-20210703101645334.jpeg
---

![Header Image - Flutter Web: Should I use it? (Part 1 — SEO)](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*DTmKsPfjSR-mjw7sqeVwyQ-20210703101645334.jpeg)

Many times online the question has been asked “Is flutter good for web”, and what many developers fail to truly understand is that is a very broad and open question and there are many factors that go into saying yes, no or maybe.

While I am most certainly no expert, I have been around the block for a little over a decade and have spent the last 2+ years working with flutter for mobile and web and have learned a few things, both before and during that, that gives me hopefully some useful insight into that question, insight that may help you answer that question for yourself.

The main problems that is highlighted is SEO, and the justifications given for that are **Search Indexing **capability or lack thereof**, **and **Performance**, which are very valid concerns in general, but there is actually more to it than that.

## Search Indexing…

Let’s start with what is probably the most thrown around is the concern, that Flutter for the web is bad for indexing, as Flutter paints with canvas, it cannot be scrapped by current web scrapers (bots), however, I feel that most of the people screaming this from the rooftops have little to no understanding of what that actually means and seem to feel that your website is the one and the only thing you need to concern yourself when evaluating SEO and search rankings, which is impossibly far from the truth, that would be like saying that the sun would make a good holiday destination.

SEO is a massive thing, you could almost think about it as a living organism that evolves and grows with every interaction and encounter through its journey through the “world”. Search engines are constantly evolving their algorithms and scaling up their scrapers/bots to get the most accurate information possible, filter out the fake and the garbage and tailor the search results to be as relevant to YOU as they can, and this is even more so when it comes to Google.

Google has been keeping tabs on you for years, if not decades, it probably knows you better than you do yourself, and when using it, you are one of the biggest factors it considers when it considers how relevant a result is.

Many believe that for a site to be “good” for SEO it needs metadata and text content, and this is not wrong, but it’s also very contextual, a small site with minimal text is not generally enough for a web scrapper and the search engines to determine relevance and quality.

### An Example…

Take [The Boring Company](https://www.boringcompany.com/not-a-flamethrower) as an example, when the site first launched it was nothing but a picture of the “not a flamethrower” and maybe a paragraph's worth of text, by many peoples understanding of how SEO works, as this site has little not no text content for these scrappers to analyze, it really better than a small Flutter site which is not scannable? In that context, the site is nearly as worthless, yet we probably all know about it, and most of us have visited the site before and probably googled for it.

2 key things work in that sites favour with regards to SEO, Elon himself is probably the biggest, but he is merely a catalyst, and then the name “not a flamethrower”, it’s pretty unique, especially when you combine these 2 factors.

Here is pretty much what happens to make a site that seemingly worthless for SEO, and SEO gold mine, Elon, he tweets about it, thousands, if not tens of thousands of his follower's retweet, from then bloggers, YouTubers and legitimate news outlets pick up on it. Now the entire internet is talking about it, linking to it, discussing what it is or could be.

All of this talk, reference and backlinking is giving the search engine algorithms reference and context to what this website is, or could be, about and not only that, they are finding this link and visiting and revisiting this site hundreds of thousands of times, from places like Twitter, Facebook, blogs and news sites.

Now, all of a sudden, this apparently meaningless, contextless thing is probably one of the most important things on the internet. How the site is built, or how much text it has, how much text these scrapers can scrape from it is utterly meaningless, it has zero bearings on this particular websites SEO capabilities, the main things Flutter is being slated for.

**Back to Flutter and Search Indexing…
**In the grand scheme of things, Flutter is neither good nor bad for SEO when you consider its ability to be scraped by a web scraper. Its performance does not help it, but we will touch on that a bit later.

Especially in their early days React, Angular and Vue all suffered from the same handicap, then came out services like [prerender.io](https://prerender.io/) and capabilities like Server-Side Rendering (SSR), which allowed us to detect when a search engine bot or web crawler was hitting the website and give them static HTML version of that particular page if it was a less dynamic site we could even simply SSR it for everyone, which would help with performance.

For Flutter, at least to the best of my knowledge, there is no current way of implementing an SSR solution, and given how reliant Flutter still is on the canvas for rending, it may not be entirely possible or viable to attempt such a thing at this stage.

****

In the next part, we will get into Performance, the next big factor to consider when deciding on Flutter for web in your project.

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

* [React to Flutter: One Developers Journey — Part 1](https://remelehane.dev/posts/react-to-flutter-one-developers-journey-part-1/)
* [Developing on an M1 Mac (Flutter)](https://remelehane.dev/posts/developing-on-an-m1-mac-flutter/)