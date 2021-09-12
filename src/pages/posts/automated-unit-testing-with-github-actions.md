---
stackbit_url_path: posts/automated-unit-testing-with-github-actions
title: Automated Unit Testing with GitHub Actions
published: false
date: '2021-09-12T09:00:00.000Z'
excerpt: How to automate your flutter unit testing with GitHub Actions
tags:
  - development
  - unit-testing
  - GitHub
  - automated-testing
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/flutter_gh_actions.jpg
cover_image: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/flutter_gh_actions.jpg
canonical_url: https://remelehane.dev/posts/automated-unit-testing-with-github-actions
---

![flutter_gh_actions](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@main/uPic/flutter_gh_actions.jpg)

Today we going to discuss the nicely simple way in which you can use GitHub's actions to automate the unit testing for your Flutter project. This can be very handy to prevent broken code from going to production, or even just as a sanity check for the code reviews. 

### Let's get started

Firstly, let's get a look at what our result is going to look like...

```yml
name: Flutter Testing

on:
  workflow_dispatch:
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2.3.4
      - uses: subosito/flutter-action@v1.5.3
      - name: Install packages
        run: flutter pub get
      - name: Run generator
        run: flutter pub run build_runner build
      - name: Run test
        run: flutter test test
```

Now let's dive into what is going on here.

First, we simply start off with a name and the triggers, this action will trigger for any pull-request made against the main branch as well as on "workflow_dispatch", which is GitHub for manually.

The jobs section is where the actual work happens.

GitHub exposes Linux, Windows and macOS environments for you to run actions within, as unit tests are platform agnostic, I prefer to run these against Linux, in part is it is the "cheapest" option, while for OpenSource projects you have unlimited minutes, private projects are collectively limited to 2000 minutes per month, with time multipliers based on the platform being used, you can read up about that [HERE](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions).

The steps describe the order of flow for your action, which almost always will start with [actions/checkout@v2.3.4](https://github.com/actions/checkout), which is the action that checks out the code into the instance of the action.

As we are trying to test a Flutter project, we need to install flutter into the instance, for this we are calling [subosito/flutter-action@v1.5.3](https://github.com/subosito/flutter-action), but default this will install the latest stable release, but you can configure this to another release or even pin it to a specific version.

Next, we start interacting with our own code, we start by running flutter pub get so that we can install all our packages into the instance.

The "Run Generator" step is an optional one for those of us who make use of code generation in our projects, something you can skip if you are not already running it locally.

Lastly, we run our tests with `flutter test test`, while the 2nd "test" is not required, it is actually the path reference to the test folder, something I need to define in order for some of the mocking functions to work correctly within a few of my projects.

### It's really that simple

Yes, it really is that simple, that is all you need to be able to run your automated tests using GitHub actions, how long it takes would depend on the size of your project. My smallest project which is about a handful of files takes just over a minute, one of my largest was thousands of files with just over 1k test over 12k LOC and 80% coverage took about 9 minutes.

---

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you liked it, a heart would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

---





