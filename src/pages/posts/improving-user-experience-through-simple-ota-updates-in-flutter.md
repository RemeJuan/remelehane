---
stackbit_url_path: posts/improving-user-experience-through-simple-ota-updates-in-flutter
title: Improving User Experience through simple OTA updates in Flutter
date: '2020-05-18T07:31:01.000Z'
excerpt: >-
  Background  When I started building out the new mobile app for Wyztalk there
  where a few things on...
tags:
  - localization
  - flutter
  - flutterappdevelopment
  - flutterui
template: post
thumb_img_path: https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*BGGjw3RFKH5yLy75441v2g.jpeg
---


![Wyzetalk Flutter](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*BGGjw3RFKH5yLy75441v2g.jpeg)

**Background**

When I started building out the new mobile app for [Wyztalk](https://www.wyzetalk.com) there where a few things on my personal ToDo list that obviously had great benefit to the business, one was a CI pipeline ([Article](https://dev.to/remejuan/deploying-a-flutter-app-on-azure-pipeline-43bo)) which I recently completed, this one however was something I got right quite early on.

With our current Ionic v1 app we needed to roll out a complete app deploy for CSS or Localization updates. While my implementations for both the UI and locale supported simply being hosted, even being small files, not something you want to be sending down the wire unnecessarily.

For the [Flutter](https://flutter.dev) app I spent quite a bit of time working on a simple way implement this, for the localization we are using [easy\_localization](https://pub.dev/packages/easy_localization) as it was one of the simpler implementations that both supported json as well as online locale, something very useful for initial development.

For the UI (CSS) I also opted for a json solution as it allowed me more control over specific elements and edge cases which come up more often in a white label product and ended up being beneficial for this problem as well.

**Solution**

Both solutions are quite similar, but the premise behind it is that at build time we ship the current version of the Styling and Locale files, each of these files also includes a last updated date.

When the user first launches the app we copy these assets from the asset bundle over to the document storage.

In the main.dart file we have the following methods being called


```dart
// Copy bundle assets into Documents directory_  
await LocaleHelpers._copyLocaleFiles_();
await ThemeHelpers._copyTheme_();
```


then a bit further down we have these 2 to trigger the updates


```dart
// Background update of Locale_  
unawaited(LocaleHelpers._updateLocale_());

// Check for theme updates_  
unawaited(ThemeHelpers._updateTheme_());
```


The key difference between the locale and style copy methods is with the supported locale which can be defined with a build-time config.


```dart
static Future<void> _copyLocaleFiles_() async {
  String path = await FileHelpers._verifyOrCreateDirectory(_directory);

  for (final locale in globals.supportedLocale) {
    String localeKey = locale.toString();
    String localePath = '$path$localeKey.json';

// Check if the file already exists, if not copy it over
if (!FileHelpers._verifyFileExists(localePath)) {
      String assetPath = "assets/locale/$localeKey.json";
      String data = await rootBundle.loadString(assetPath);

      await FileHelpers._writeStringToFile(localePath, data);
    }
  }
}
```


For updating the theme we first do a small check with the API by sending the last updated date from our current file to check if an update is available.


```dart
static Future<void> _updateTheme() async {
  String path = await FileHelpers._verifyOrCreateDirectory(_folderName);

  var url = ApiEndpoint.uri('/theme').toString();

  try {
    bool shouldUpdate = await _checkIfUpdated();
    if (shouldUpdate) {  
var response = await Session.apiGet(url);

      String localePath = '$path/$_fileName';
      await FileHelpers._writeStringToFile_(
        localePath, 
        json.encode(response)
      );
    }
  } catch (error) {
    debugPrint('updateTheme - Unable to update theme');
  }
}
```


The locale function follows the same idea but includes the loop as shown in the copyLocale to check each locale individually for an update.

While not a massive saving in the grand scheme of things, this does remove the need to host such sparsely updated resources or update a 10mb app for ~7kb of styles or locale.

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

****

- [Deploying a Flutter App on Azure Pipeline](https://remelehane.dev/posts/deploying-a-flutter-app-on-azure-pipeline/)
- [Flutter: Using Self Signed SSL Certificates in Development](https://remelehane.dev/posts/flutter-using-self-signed-ssl-certificates-in-development/)
