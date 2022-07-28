---
stackbit_url_path: posts/flutter-data-testing
title: "Flutter: Data Testing"
published: false
date: '2022-05-09T12:00:00.000Z'
excerpt: This time we take a look at using predicated when testing data classes
tags:
  - flutter
  - flutterweb
  - fluttermobile
  - flutterdevelopment
template: post
thumb_img_path: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/07/upgit_20220728_1658994619.jpg
cover_image: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/07/upgit_20220728_1658994619.jpg
---

![shahadat-rahman-BfrQnKBulYQ-unsplash](https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/07/upgit_20220728_1658994619.jpg)

In a previous post, we discussed using `find.byPredicate` for more accurate and bulletproof widget testing.

[Flutter: Up your testing game](https://remelehane.dev/posts/up-your-testing-game/)

In this post we are going to quickly go through that same logic, but for data related unit testing.

For the 95% of my data models, I would use [freezed](https://pub.dev/packages/freezed), a wonderful package that makes one life a lot simpler when it comes to data classes, including adding in a few utility methods as well as simplifying unit testing by handling equality, something I previously achieved manually and with some help from [equatable](https://pub.dev/packages/equatable).

However, there is a bit of boilerplate when using `freezed` as it works with code generation.

```dart
enum MenuItemKey {logout, dashboard}

class MenuItem {
  final MenuItemKey key;
  final String localeKey;
  final PageRouteInfo route;

  MenuItem({
    required this.key,
    required this.localeKey,
    required this.route,
  });
  
  static List<MenuItem> menuItems = [...]
    
  static List<MenuItem> itemsToDisplay(List<MenuItemKey> excludedKeys) {
    return menuItems
        .where((element) => !excludedKeys.contains(element.key))
        .toList();
  }
}
```

Take this class, for example, adding in `freezed` would have been straightforward, add 2 or 3 lines of code and an extra generated file, however to me it felt unnecessary as this is a model I created for simply managing a navigation list, there is no data to test, no relation to an API, no need for equality or the utility methods, etc.

There is a menu in my application, which gets provided the `menuItems` list and with that, I generate the nav items.

However, I do still want to be able to accurately test `itemsToDisplay`, the 1 bit of logic attached to this class, by default all items are based on the generation function, however not all screens have all the nav items. The login screen would have no need for the Logout button for example.

## The Test...

As with widgets, we can use `predicate` as part of our expect function, to drill down into data models and compare results with defined values.

```dart
  test('should return only logout menu item', () async {
    //act
    final result = MenuItem.itemsToDisplay([
      MenuItemKey.dashboard,
      MenuItemKey.support,
      MenuItemKey.profile,
    ]);
    //assert
    expect(
      result,
      predicate(
        (List<MenuItem> items) =>
            items.length == 1 && items.first.key == MenuItemKey.logout,
      ),
    );
  });
```

In the above example, we would have had 4 items in the `menuItems` list and made the decision to filter out all BUT `logout`.

In order to verify our function is working then, we use `predicate` which takes a function as an expectation, to which we have the data type we are expecting and then return a check which yields a boolean result.

In this case, we had a list that contained 4 menu items, we excluded 3 of them so we verify that our list only has 1 item in it, and to make sure the correct item remains, we verify that the first (only) item in the list has the key of `MenuItemKey.logout`, which is the enum value assigned to the navigation item.

## Conclusion...

As you can now see, `find.byPredicate` and `predicate` are 2 very useful methods that we as testers should keep in mind when writing out tests. They can help with less-standard use cases and allow us to write a higher-quality test.

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome.

Thanks for reading.

****

Wish to carry on with the topic of Unit Testing, take a look at:

- [Widget testing: Dealing with Renderflex Overflow Errors](https://remelehane.dev/posts/widget-testing-rendeflex-overflow/)
- [Flutter: Up your testing game](https://remelehane.dev/posts/up-your-testing-game/)

Photo by [Shahadat Rahman](https://unsplash.com/@hishahadat?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/data?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)
