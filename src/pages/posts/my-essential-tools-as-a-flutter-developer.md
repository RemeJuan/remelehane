---
stackbit_url_path: posts/my-essential-tools-as-a-flutter-developer
title: My essential tools as a Flutter Developer
date: '2021-07-25T09:00:00.000Z'
excerpt: Here are some of the tools that I find essential in my day to day as a Flutter developer
tags:
  - flutter
  - flutterdevelopment
  - fluttertools
  - flutterappdevelopment
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*84xICiaeVfpxyZ4lgDSlLQ.png
---

## My essential tools as a Flutter Developer

![Representative technology image](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/1*84xICiaeVfpxyZ4lgDSlLQ.png)

## My essential tools as a Flutter Developer

As developers, our daily tools are essential to our productivity and maybe even sanity. For all the complex things we do on a daily basis, we need our tools to either be as simple as possible, or as powerful as possible. Ideally both :D…

As a Flutter developer, my tool-stack is not a complicated one, there are a few tools that I use all day, every day to make my job, my passion, simpler and more productive.

## 1. IntelliJ IDEA

While man, if not most developers I work with make use of VSCode, that is a tool I left behind nearly 4 years ago, it’s actually not even installed on my current machine any longer, and while I am sure most, if not everything IDEA does for me can be done in VSCode, I am past the point of building up my own tooling.

For me IDEA, especially when working with Flutter, just has that secret sauce, I prefer the user interface, accessibility of certain tools, and functionality. I find it a lot more performant with large projects and the global search functionally is just great, and while VSCode does have that, this just seems to work better and more expansively, being able to do a wildcard search for files, classes and functions all in one place just simplifies finding things when you are not 100% sure what you called it.

I can also be very verbose when committing, I like to group contexts of changes and when working on a feature or a bug, there are times when you change quite a few things, but not all of them would be related to the same commit message, I will never commit “fixed stuff”, and I have seen that already…

While VSCode can do this, it is vastly more complex to achieve, and that changes level commits, with IDEA I can go through a file and unselect groups or lines of changes that I feel are not relevant to the commit I am trying to make, things that will be best served with a better commit description.

I personally use the paid version of IDEA, unlike the free community version it also supports web-related languages like JavaScript, HTML, and CSS, which is handy for the few projects I used to work on before I went all-in on Flutter.

### Installed Plugins

Here are some of the plugins I added to IDDEA to make my life easier.

* [BLoC](https://plugins.jetbrains.com/plugin/12129-bloc)

* [Flutter Enhancement Suite](https://plugins.jetbrains.com/plugin/12693-flutter-enhancement-suite)

* [Flutter Snippets](https://plugins.jetbrains.com/plugin/12348-flutter-snippets)

* [GitToolBox](https://plugins.jetbrains.com/plugin/7499-gittoolbox)

* [Rainbow Brackets](https://plugins.jetbrains.com/plugin/10080-rainbow-brackets)

* [Save Actions](https://plugins.jetbrains.com/plugin/7642-save-actions)

[**LINK**](https://www.jetbrains.com/idea/download/)

## 2. Alfred

Alfred is something that will only benefit Mac users, it's a spotlight replacement and then some, it supports pretty much everything spotlight does but is extendable with custom workflows and configurations.

Alfred is extremely powerful in what you can do with it, from basic things like launching apps on your machine to doing inline web searches and even calculations and conversions.

What I probably use most from Alfred are some of the custom web searches I have added like `ppac` which is short for pub package and I can type the name of any dart/flutter plugin after that to just directly the page, or `pdev` which is a search for pub.dev.

After that, it would be the “[calculate anything](https://github.com/biati-digital/alfred-calculate-anything)” workflow which uses a natural language process to calculate pretty much anything from simple math to currency and unit conversions.

Simply typing in “50usd in euro” will do the currency conversion for you, you can also set a base currency, which would be the default, so if your base is “euro” then all you would need to type is “50usd”.

[Github Repos](https://github.com/edgarjs/alfred-github-repos) is another one I use often, it searches either Github or your own repos depending on your prefix command to quickly launch the selected result.

Other useful things would be [Kill Process](https://github.com/nathangreenstein/alfred-process-killer), for killing a running process by searching for it.

These are just some of the workflows I use and a small fraction of what is out there, and if there is not something that does what you need, you can always just write it yourself as workflows can be created in most languages.

[LINK](https://www.alfredapp.com)

## 3. ZSH + oh-my-zsh

Pretty sure by now everyone knows about zsh, but it can definitely no the left off any list of tools for developer efficiency and productivity, as an enhancement on bash, combined with the extendability of oh-my-zsh, there are soo many ways this could improve productivity if for no other reason that the built-in aliases you can enable with plugins, while it’s simple enough to write your own aliases, it’s just easier to get them all set up and with soo many plugins, it’s easy to simply pick and choose the ones that will enhance your workflow. ([Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins))

On top of that, the [theming](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) just adds that touch of personalization to your working environment, spicing it up with color and usually adding the active branch when in a version-controlled folder.

I have been using it for a good 4 maybe 5 years and do not see myself going back, it’s simple yet powerful.

As they say

>  Oh My Zsh will not make you a 10x developer…but you may feel like one.

[LINK](https://ohmyz.sh) and my [zshrc](https://gist.github.com/RemeJuan/ba8dc0fbcea4d3709b1ef7640d58c572) file if you are interested. It will give you a bit of extra insight into some of the available features.

## **4. Spark**

[Spark](https://sparkmailapp.com) is probably one of the best and simplest mail apps I have used in my life, while I do often prefer the web UI for managing emails, there is something to be said about the convenience of a single app to deal with multiple mail accounts, I am pretty sure most, if not all of us have at least 2 email accounts, personal and work/professional.

As a mail app it’s nothing spectacular, but I think that is what makes it great, they added a few useful features, but tried to keep it as simple and user-friendly as possible, they did not try and reinvent the wheel on this one.

It loads all your mail accounts and calendars into consolidated views, for organizations they offer intelligent, and in my experience, accurate suggestions as to where you would want to archive this mail.

Spark also uses an SSO when you initially sign up to create a spark account for you, this comes in handy when you have multiple devices as then you only need to set things up on one of them and your accounts sync to your other devices.

They also support intelligent notifications, which allocate importance to incoming emails to determine whether or not you need to be alerted or simply increment the number on the app badge, much like GMails priority mail. The only thing I found a bit strange, which may be by design, is the importance categorization differs by device, so you may get notified on your iPad and not on your phone for the same mail.

You can also disable notifications on an account level per device, which can be handy, for me, work emails only notify on my Mac, never my phone or iPad.

My essential tool stack is actually quite small, obviously, there are many other tools sitting on my Mac right now, but these would be the 4that have the biggest impact on my day-to-day.

I hope you found this post informative, or entertaining. If you have any questions or comments, please feel free.

***

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a heart would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.