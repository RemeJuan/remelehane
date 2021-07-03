---
title: IFTTT filters are actually quite capable
stackbit_url_path: posts/ifttt-filters-are-actually-quite-capable
date: '2021-06-15T07:02:15.000Z'
excerpt: >-
  I have been on the pro subscription for [IFTTT](http://ifttt.com), and was not until recently that I decided to actually take in and take a look at just what it could do.
tags:
  - automate
  - life
  - iffff
  - javascript
template: post
---

![](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*yPXQ1XYpS3VHJsPrLK24FQ.png)

I have been on the pro subscription for [IFTTT](http://ifttt.com), and was not until recently that I decided to actually take in and take a look at just what it could do.

I have been using IFTTT itself for many years so have quite a lot of workflows already set up, many of them just tweet articles I like from sites like Reddit or Medium, but that usually also means hitting my [Twitter](https://www.twitter.com/RemeJuan) account with a few to quite a few new posts in a single shot. I decided it may be better to trickle that a bit and bring [Buffer](https://buffer.com) into the mix, for me the free one with up to 10 posts in the queue would have been fine, does not matter if a few get lost.

Once I had updated all these workflows to use Buffer instead of Twitter directly, I thought maybe the filter could help with another workflow that was not possible directly.

#### Filters, first stab…

The first stab was really simple, I wanted to tweet photos that I liked (upvoted), but only if it was from [/r/EarthPorn](https://www.reddit.com/r/EarthPorn), this would then trigger a post with an attached image.

I presumed filters would be this somewhat complex set of dragging and dropping logic around, which is why it was not yet available on mobile, I was quite happy to see that what we got was actually a code window that took JavaScript, with a reasonable sprinkling of ES6 in the mix too.

This also then explains why it was not available on mobile, I did manage to put together the very simple workflow I wanted for /r/EarthPorn via my iPad on their website, but when I dove into a move complex one that failed pretty quickly.

In order to set up a filter, you do need to provide both the if and then first, this is required for you to be able to get the correct environment variables that will be available.

```
const sub = Reddit.newLikeByYouReddit.Subreddit.toLowerCase();

if (sub != 'earthporn') {
  Buffer.addToBufferWithPhoto.skip();
}
```

This is the very simple one that I had set up, as you can see all I am doing is checking that the SubReddit’s name is EarthPorn, if not, it simply skips this post, which would then NOT add this to my Buffer queue.

#### Let’s increase the complexity…

This is where I dove into a more creative filter flow.

A lot of what gets shared is often interesting article that I come across from Reddit, and bookmarking the post is the easiest way to trigger an automated flow, far simpler than me manually sharing the URL to Twitter myself.

> I will spend 2 days automating a 2-minute repetitive task just so that I don’t have to keep repeating it…

In this case, filters would actually allow me to not only automate the posting, trickle them as to not flood my feed, but also enhance them, as with some reasonably simple logic I can manipulate the entire post, and for this case, very simply add in likely appropriate hast tags.

```
const sub = Reddit.newSaveByYouReddit.Subreddit.toLowerCase();
const title = Reddit.newSaveByYouReddit.Title.toLowerCase();

const tags = [];

// FE/JS Dev
const feSub = sub == "frontend" || sub == "javscript";
if (feSub) {
  tags.push("frontend", "development", sub);

if (title.indexOf("css") != -1) tags.push("css", "styles", "web");
  if (title.indexOf("html") != -1) tags.push("html", "layout", "web");
  if (title.indexOf("javascript") != -1) tags.push("javascript");
  if (title.indexOf("ecmascript") != -1) tags.push("javascript", "ecmascript");
}

const uniqueTags = tags.filter((value, index, self) => {
  return self.indexOf(value) === index;
});

const hashTags = tags.map((t) => `#${t}`);

const url = Reddit.newSaveByYouReddit.PostURL;

const message = `
${title} vi a/r/${sub} ${url}
${hashTags.toString().replace(/,/g, ' ')}
`;

Buffer.addToBuffer.setMessage(message);
```

As you can see, this one is a bit more involved than my first attempt, and this is not all of it, but it’s pretty repetitive as I am just applying much of the same logic across different subs.

I am pulling out both the title and the subreddit into variables as lowercase versions for easier comparison and have an empty array to push tags into.

Depending on the sub I add a set of basic tags as well as check the title for keywords for other possible relevant tags.

To be safe I also iterate through the resulting list of tags to ensure there are no duplicates, from there I build up a new message to be tweeted and use the available setMessage function provided by the buffer filter to override the message that would have been sent.

#### Final thoughts…

As you can see, the second one is more complex, at their core both of these are still pretty simple use cases and I can imagine that will a little creative thinking and possibly some further enhancements from IFTTT down the line, this could become a very capable tool for automation.

Tweets are probably one of the simplest things one could achieve via IFTTT, I know I have some other, simple, yet interesting ones, including one that switches on my geyser when I finish a cycle. Who doesn't like a hit shower… lol.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

[Working from home works for me…](https://remelehane.dev/posts/working-from-home-works-for-me/)