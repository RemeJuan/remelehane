---
title: "GDC - Are You Flutter'ed Yet?"
hide_title: false
seo:
  title: Google Developer Conference | Reme Le Hane | Flutter Developer
  description: Google Developer Conference | Reme Le Hane | Flutter Developer
  extra:
    - name: 'og:type'
      value: website
      keyName: property
    - name: 'og:title'
      value: Reme Le Hane | Flutter Developer
      keyName: property
    - name: 'og:description'
      value: Reme Le Hane | Flutter Developer
      keyName: property
    - name: 'og:image'
      value: images/4.jpg
      keyName: property
      relativeUrl: true
    - name: 'twitter:card'
      value: summary_large_image
    - name: 'twitter:title'
      value: Reme Le Hane | Flutter Developer
    - name: 'twitter:description'
      value: Reme Le Hane | Flutter Developer
    - name: 'twitter:image'
      value: images/4.jpg
      relativeUrl: true
template: page
---
<p>In April 2021, I was priviliadged enough to be able to be one of the speakers for the Googe Developer conferences Flutter session, "Are You Flutter'ed Yet?" along with 2 other presenters.</p>

<p>
  THe following is the transcript, and you can also watch the recroding on <a href="https://www.youtube-nocookie.com/embed/oJSMT97rURs"  target="_blank">YouTube</a> and alos download the associated <a href="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/GDC_Presentation.pptx"  target="_blank">Powerpoint</a>
</p>
<hr/>
<p>Good Evening all, my name is Reme and I have been working as a Frontend Architect at Wyzetalk and have been developing their new Flutter mobile application which will be replacing their existing Ionic version 1 application.</p>
<p>As those of you who have already begun working with Flutter may know, one of the bigger challenges with a Flutter codebase is testing, currently, the documentation on that topic is a little dismal, with examples covering only some of the most basic use-cases.</p>
<p>Working on this application at Wyzetalk, we have gone far beyond what can easily be found in a google search, or a lot of google searches for that matter.</p>
<p>To aid with testability, we built the application following a domain-driven approach using BLoC as well as dependency injection using get_it. The strong focus on testing has also had to influence our choice of external packages, as some have proven easier to integrate with testing than others.</p>
<p><small><b>[SCREENSHOT OF COVERAGE REPORT]</b></small></p>
<p>Our first production-ready version, aka our MVP, is currently sitting just over 12300 lines of testable code, there are probably quite a few thousand more lines sitting in generated files, but those are all excluded from the coverage report, which leaves us with a very nice 83% test coverage which is still increasing and has most certainly not been without more than it’s fair share of challenges.</p>
<p>Today I am going to touch on 2 of those challenges and go through a bit of how we dealt with them.</p>
<p><small><b>[WHITE LABEL EXPLAINER]</b></small></p>
<p>As a white-labelled, international a localized product, one of the initial challenges we faced early on was being able to run our tests with localization in place. As users can change their language, one of the simplest ways to be able to test the available language switcher was to just expect to find a specific piece of text in the selected language. </p>
<p>Occasionally we would also run into scenarios where UI’s were unable to be tested as a result of a localization dependency that was not available in the test context.</p>
<p>For localizing the application, we chose the EasyLocalization plugin, in part as it supported both local and remote data sources, and the remote came in very handy during the initial development phase, and was later updated to use an OTA updatable local source. EasyLocalalization works with simple object path notation, which was how the plugin for our other applications works which kept things consistent.</p>
<p>Being localization, it’s one of the few things that have to be set up on the main.dart file, so bringing that logic into the testing space took a fair amount of thinking, and as usual, the resulting code is quite disproportionate to that amount.</p>
<p><small><b>[SLIDE WITH SCREENSHOT OF THE RESULTING CODE]</b></small></p>
<p>Here we have the helper function I created which allows, among other things, us to wrap each widget that we are testing with the EasyLocalization provider widget, which in turn gives the test instance access to the locally available mock JSON files for our locale data.</p>
<p><small><b>[SLIDE WITH INITIAL SCREENSHOT AS WELL AS EXPANDED VIEW TO SHOW DIRECTORY CODE]</b></small></p>
<p>
The TEST_MOCK_STORAGE variable, as you can see, is being derived by getting the current directory path from the FileSystem and the relative path for the fixtures. This however does require us to suffix the `flutter test` command with the folder name test.
</p>
<p>This is not the only place where we need to access mocked files within our tests, so that on its own, while simple, is a very useful thing to set up for testing in Flutter.</p>
<p><small><b>[SECOND TEST CASE INTRO SLIDE]</b></small></p>
<p>Now I would like to move onto a more creative test implementation I set up, something far less likely to be run into out in the wild, but I felt it spoke to the capabilities of being a bit more creative when approaching more complex or unusual testing scenarios in your application.</p>
<p>I would hope that none of you ends up running into a scenario quite like this, very much an edge case scenario born from a very specific business requirement and a few days later I did manage to come up with a cleaner implementation of the UI logic around this, but I was still pretty impressed that I was able to write a test for this that I could actually be confident with.</p>
<p><small><b>[SCREENSHOT OF TEST COVERAGE BLOCK]</b></small></p>
<p>I am not one who believes in writing tests for the sake of writing tests, while coverage is a nice measurement for the overall, tests need to be written for the purpose of testing the business and UI logic before worrying about what lines are being hit, it’s just a nice way to sanity check that you have hit all your cases.</p>
<p>As creative and possibly out there as this test may be, it genuinely works and can easily be made to fail with an invalid expectation.</p>
<p>Before I show you the test that was written, let me give you a little bit of background behind the UI and logic that I needed to test.</p>
<p><small><b>[SCREENSHOT OF ERROR MESSAGE]</b></small></p>
<p>There is a reasonable level of flexibility in our application, and with that comes the need to render raw HTML, something Flutter does not technically support within the native applications. To work around this I made use of an in-app-browser which allows us to maintain backwards compatibility with some of the existing API responses.</p>
<p><small><b>[URL LAUNCHER SNIPPET]</b></small></p>
<p>As part of the API response can include hyperlinks, which simply just work within the Ionic application, we also have a custom URL launcher as depending on the link that is provided by the API, the app may need to navigate through the navigation tree or switch over to another tab within the PageView.</p>
<p>As part of the API response can include hyperlinks, which simply just work within the Ionic application, we also have a custom URL launcher as depending on the link that is provided by the API, the app may need to navigate through the navigation tree or switch over to another tab within the PageView.</p>
<p>At this point the app is still a bit of an MVP, so not all of our current features have been implemented in the Flutter app as of yet, added to that, not all devices may support certain URL schemas. In order to maintain a quality user experience, we wanted to be able to inform the user if something is not yet supported and to maintain consistency, we wanted to be able to display the same SnackBar that is used throughout the rest of the application.</p>
<p>The first implementation of this error handling involved returning the Snackbar directly from the utility class, which can be seen on the current slide. While testing a class or widget is quite straightforward, mixing the 2 creates a different set of complications. I would definitely put this in the “if all else fails” category of things to do, however, I was still able to write a test that I am personally very confident with to test this scenario.</p>
<p><small><b>[SLIDE SHOWING UNUSUAL TEST CASE]</b></small></p>
<p>Here we have the full test, which may not be easily visible to everyone, it is a fair amount of code to try and showcase in a slideshow, so let’s break this down into smaller chunks as there is quite a bit going on here, the one thing to take away from this, at this time is that I am using  `testWidget` instead of `test`, as we are ultimately testing the UI in the end.</p>
<p><small><b>[SLIDE SHOWING FUTURE HELPER]</b></small></p>
<p>After setting up the variables for the test, I created a small helper within the test as I was running into issues executing all the UI logic, so I needed a short delay before actually calling the launchUrl function.</p>
<p><small><b>[SLIDE SHOWING WIDGET]</b></small></p>
<p>In order for the utility function to work correctly and for the Snackbar to actually render, I needed to use a real BuildContext, instead of providing a mocked one, so as with all our Widget tests, we start with our “provideLocalizedWidgetForTesting” helper that you would have seen earlier.</p>
<p>We then follow that up with a LayoutBuilder in order to get a real widget context to pass into our small helper and ultimately into our HTML utility function.</p>
<p>As most of you may know, the most common way to execute a future inside a widget is to use the FutureBuilder, so we have one of those inside the LayoutBuilder to execute the utility function. As we are not concerned about all the other connection states for the test, we are only specifically checking for the “done” state and in both cases we simply return a “SizedBox.shrink()”.</p>
<p>To date this has to be the most unusual way I have written a test, but stitching all of this together allows us to have executed both the utility classes business logic and verify that a localized Snackbar is being rendered in the UI, as the “Podcast” feature’s link, which is being tapped on, is one that is yet to be implemented in the Flutter application.</p>
<p><small><b>[SLIDE SHOWING EXPECTATION]</b></small></p>
<p>The rest of the test is very straightforward following the normal flow of pumping the widget, settling the LayoutBuilder and then one final pump with a 1-second delay for the FutureBuilder to complete followed by expecting the “FlushBar” to be rendered, which is just a much nicer looking and more capable Snackbar.</p>
<p><small><b>[OUTRO SLIDE]</b></small></p>
<p>That covers the 2 extremes of testing we have implemented over the last few months, and I hope that the useful case and the extreme case gives you a better understanding of what is possible with testing in Flutter.</p>
<hr/>