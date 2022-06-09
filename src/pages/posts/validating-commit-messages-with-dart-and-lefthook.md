---
stackbit_url_path: posts/validating-commit-messages-with-dart-and-lefthook
title: Validating commit messages with dart and Lefthook
date: '2020-08-31T07:16:01.000Z'
excerpt: >-
  Something I had been trying to work out for my Flutter project for some time
tags:
  - dart
  - flutter
  - flutterdevelopment
  - git
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*kproRaJTnQivymfDqsxTkg.jpeg
---


![Validate Commit Messages Banner Image](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*kproRaJTnQivymfDqsxTkg.jpeg)

Something I had been trying to work out for my Flutter project for some time was validating commit messages, initially, I used commit-msg-validate but having a node dependency in a Flutter/Dart project does not seem right and when the team grew to beyond myself I worked on moving all of the automation scripts I had written in JS over to dart and while there are still a few node dependencies left, they are purely for use in the CI pipeline.

For the purpose of executing git-hooks across the team, I added [Lefthook](https://github.com/Arkweid/lefthook) to the project and initially only used pre-push for executing the test scripts, but only recently had an idea for how to execute the commit-msg hook.

### The Hook

I found out that the commit message is stored in a plain text file COMMIT\_EDITMSG inside the ./git folder, which would be easy to read up into a string within Dart.

I added a git\_hook folder with a commit\_message.dart file, which I could later run from Lefthook.

Within our project, and I suspect many at this point we follow the semantic commit message approach, you can read more about that [HERE](https://nitayneeman.com/posts/understanding-semantic-commit-messages-using-git-and-angular/).

Our commit message file looks like:


```
_import_ 'dart:io';

_dynamic_ main() {
_final_ rootDir = Directory._current_;
_final_ commitFile = File(rootDir.path + "/.git/COMMIT\_EDITMSG");
_final_ commitMessage = commitFile.readAsStringSync();

_final_ regExp = RegExp(
    r'(fix|feat|wip|none|chore|refactor|doc|style|test)\(\w+\):\s?(\[\DEV-\d+])?.+',
  );

_final_ valid = regExp.hasMatch(commitMessage);
_if_ (!valid) exitCode = 1;
}
```


### Let's break it down


```
_final_ rootDir = Directory._current_;
_final_ commitFile = File(rootDir.path + "/.git/COMMIT\_EDITMSG");
_final_ commitMessage = commitFile.readAsStringSync();
```


The first few lines are quite simply, here we are getting the current directory and with that creating a File reference to COMMIT\_EDITMSG, which is then read up to a string, which can be validated with the following Regular Expression.


```
_final_ regExp = RegExp(
    r'(fix|feat|wip|none|chore|refactor|doc|style|test)\(\w+\):\s?(\[\DEV-\d+])?.+',
  );
```


This validates our commit message format, which starts with a prefix, these are most important for the automation scripts used to generate our version number as well as the changelog.

#### The Expression


```
(fix|feat|wip|none|chore|refactor|doc|style|test)
```


Each message has to begin with one of the above strings, after that we have our scope:


```
\(\w+\)
```


This is normally used as a module or feature reference, just to provide a small context on where the change is happening.

After that we have the optional space and Jira ticket references, all our Jira issues begin with DEV.


```
\s?(\[\DEV-\d+])
```


Finally, any characters after that,


```
.+
```


In our case a valid commit message would look like:


```
feat(video): [DEV-1223] added support for leading text
feat(video): added support for leading text
```


#### The Validation

After that, we can validate our commit message against our Regular Expression using:


```
_final_ valid = regExp.hasMatch(commitMessage);
_if_ (!valid) exitCode = 1;
```


If not valid, we simply set the exitCode to 1, anything other than 0 is an error, which would terminate the script and prevent you from commit with an incorrect message.

### Adding in Lefthook

Now that our script is complete, we can update Lefthook so that this script can be executed whenever one of us attempts a git commit.


```
commit-msg:
  commands:
    validate:
      run: flutter pub run ./git\_hooks/commit\_message.dart
```


After adding the above snippet to lefthook.yaml, one simply needs to run lefthook install to activate the hook.


```
Lefthook v0.7.2
RUNNING HOOKS GROUP: commit-msg

EXECUTE > validate
The message: none(lefthook): added commit validation

SUMMARY: (done in 1.13 seconds)
✔️ validate
```


If everything has worked, after your next commit, assuming your message met the required format, you should see something similar to the above message.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

- [Improving User Experience through simple OTA updates in flutter](https://remelehane.dev/posts/improving-user-experience-through-simple-ota-updates-in-flutter/)
- [Why we chose Flutter](https://remelehane.dev/posts/why-we-chose-flutter/)
