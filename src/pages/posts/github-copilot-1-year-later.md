---
stackbit_url_path: posts/github-copilot-1-year-later
title: "GitHub CoPilot one year later..."
date: '2021-12-28T09:00:00.000Z'
excerpt: My thoughts on GitHub's CoPilot after a year of using it.
tags:
  - GitHub
  - CoPilot
  - aiprogramming
  - aicoding
  - 3dprinting
template: post
thumb_img_path: https://cdn.hashnode.com/res/hashnode/image/stock/unsplash/81543ecbe4f5223bc251b9a7e0a0d11c.jpeg
---

![Github CoPilot](https://cdn.hashnode.com/res/hashnode/image/stock/unsplash/81543ecbe4f5223bc251b9a7e0a0d11c.jpeg)

AI is one of the current hot topics, although CoPilot may be somewhat older news. As one of the early adopters, I thought it was about time I put my thoughts down.

I started using CoPilot near the end of the beta phase, and back then I will admit I was not too impressed, but as someone who likes new toys, I stuck with it, and eventually, it grew on me, and it started becoming useful.

I never gave it the best odds, I am predominantly a Flutter developer, and neither dart nor flutter was listed as one of the supported languages, yet it soon started making very useful suggestions, nothing groundbreaking, nothing I would not have typed out myself, but boy was it handy to replace a few hundred keystrokes with a simple tap of the "Tab" key.

## Is it replacing developers?

I think this question by now has been answered to death, but I also feel like people are also not done asking it, and the simple answer is No.

Fundamentally I think there are 2 main reasons for this, the important one being it is very far off from any form of sentience. What it writes is useful, but flawed,

The second one is, clients, I have been a developer for over 12 years, and I am yet to find a customer who both knows what they want and how to articulate it, their idea of a brief is a paragraph and a few grunts.

Up until customers, people in general, actually know what they want, and how to articulate it, AI may as well be a rock.

## Where is it most useful?

As mentioned, I have been using it for some time, and I have found that it's proven itself most valuable in the areas of tedium, as well as the occasional google prevention.

### The Tedium...

What I mean by this, is those areas of simpler, repetitive code, one of my first "wow" moments, back when it was way more wrong than right, I was writing a simple function to either choose text or an icon, something reasonably simple, and the crux of the function would have been a switch statement on the incoming argument.

I typed "switch" and the preceding 15 lines were suggested, just like that, and 100% correct too.

Since then it has gotten both better and worse, it seems at times to lose a bit of context of the app and suggest the correct variable or type for example but choose a different *style,* so where I am using "qr\_code" it would instead suggest "qrCode".

Not a train smash at all, and honestly, it takes far less time to fix up the few odd mistakes like that, which the highlighted by the editor anyway, than to have written the entire thing out.

Another place it has proven to be quite useful is unit tests, if I am testing a function or class, I can often get away with only writing the first test and it will start suggesting with above 90% accuracy the rest of them, and they get more accurate once I begin correcting it, that alone has probably saved me many hours.

### The Googling...

This is something I run into less often, but can also prove itself to be very handy, one of the things you can do with CoPilot, is "request" code via comments, I have used this many times for simple functions, or even ones similar he switches above, where I can get a 90%+ accurate function, off basically asking it a question.

This also helps a lot with memory, the problem with being a developer for over a decade is there is a lot to remember, and sometimes it's the simple things can become less clear in one's head, especially when working in 3 different languages.

When unclear, the reflex is to simply google it and double-check what is in your head, however, you can get a good enough answer by asking CoPilot.

The most recent use-case was remembering just how to sort an array by another array, in dart.

```dart
      ..sort((a, b) {
        final aIndex = sortOrder.indexOf(a.type);
        final bIndex = sortOrder.indexOf(b.type);
        return aIndex.compareTo(bIndex);
      });
```

This is exactly what I got when I commented:

```dart
// sort the data by type using the sortOrder array
```

Now this is nothing amazing, or groundbreaking, and as examples go it is also pretty simple, and it can do more, but this is one of those silly, simple things that you probably should not need to, but at that moment do, need to google.

This way you can stay in your editor, and even if it is not 100%, it will get you close enough to fill in the blanks, and if you are unit testing your code, you also have that third check.

### Where does it fall short?

Not sure this one is needed as I think I have covered many of its shortcomings already, but to reiterate, it's not perfect, it will seldom generate perfect code, and odds are 8 out of 10 times you are going to need to fix at least a couple of things of its suggestions, but at least for my experience, that is good enough, it saves enough time to warrant its usefulness, to warrant it's cost.

### My Concerns...

While it may have come a cross as a lot of praise towards CoPilot, I am also not without my concerns, the problems highlighted of code being imperfect can, in less experienced hands, and especially in an untyped codebase, probably was a lot of time.

More experienced developers will more easily spot code smell, will more easily spot incorrectly suggested variables, and will more easily spot suboptimal code.

While it is a tool that can be of great benefit to developers, those still learning, and those new to the game could fall victim to inadvertently learning bad practices, CoPilot is after all trained on pretty much everything on GitHub, not everything is of high quality, some of it even has to be downright garbage.

Realistically, or at least optimistically, the algorithm was correctly weighted to more likely surface suggestions based on the higher quality code, but that will not always be the case.