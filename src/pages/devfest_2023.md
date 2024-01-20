---
title: "DevFest Cape Town 2023 - Why Choose Riverpod?"
hide_title: false
seo:
  title: DevFest Cape Town 2023 | Reme Le Hane | Flutter Developer
  description: DevFest Cape Town 2023 | Reme Le Hane | Flutter Developer
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

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_1.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_1.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_1.jpg">
  </picture>
</p>
# Who am I?

My names Reme, and I have been a developer for about 13 years now, originally starting with Javascript and moving through its various frameworks over the years.

I started with Flutter about 4 years ago and have been loving it ever since, currently the Lead Frontend Engineer for Loop and have been working with Riverpod for about a year or so.

In my Flutter journey I worked with many of the state management solutions, starting with Redux, mistakenly thinking it would be easier having come from React Redux, spent some time with BLoC and then Cubit, Provider and most recently, Riverpod which has become my personal preference.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_2.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_2.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_2.jpg">
  </picture>
</p>

## What is Riverpod

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_3.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_3.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_3.jpg">
  </picture>
</p>

As described by the creator Remi Rousselet (hope I am pronouncing that properly), Riverpod is a Reactive Caching and Data-binding Framework, so while it does make for a fantastics state management solution, that is not all that it is, along with its very flexible approach to state management, it can also help with networking, dependency injection and is extremely simple when it comes to working with tests and can even help improve the overall testability of your codebase.

In many ways Riverpod is the evolution of provider, probably one of, if not the most popular state management solution for Flutter, this means for those currently using Provider, it is extremely easy to bring riverpod in, and also very easy to roll it into the codebase gradually.

Those of us familiar with Bloc and Cubit will see some familiarity when when taking a look at Riverpods StateNotifier provider, although in my opinion, it's also a little simpler with less boilerplate

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_4.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_4.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_4.jpg">
  </picture>
</p>

Here are some simple states setup with Provider and Bloc, I suspect many of you are familiar with one, if not both of these solutions, but when we take a look at something similar with Riverpod, you can see on the left is the StateNotifier, this or the ChangeNotifierProvider which works identically to the ChangeNotifier from Provider, this is the direction you would more commonly go for with a general state management setup, on the right is probably the simplest possible way to set up a Provider with Riverpod, a literal on liner and while not something you would use often, the option does exist for simply storing a single value in state, without all the verbose boilerplate.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_5.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_5.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_5.jpg">
  </picture>
</p>

While it’s extremely rare that one would choose to set up a state for storing a single value, this is where the dependency injection can come into play, as Riverpod providers are globally accessible, but locally instantiated the data stored can be accessed and even updated from anywhere in the application if you so choose.

## Riverpods Extensions

To help with controlling the global access to your state’s data, Riverpod provides 2 extension methods, namely autoDispose and family.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_6.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_6.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_6.jpg">
  </picture>
</p>

The autoDispose extension does very much what its name describes, once the widget instantiating the Providers is unmounted, so is the Provider along with all its data.

The family extension, which took me a while to fully understand, is the real powerhouse here, it serves two purposes, the first is simply the ability to pass data into your provider. The one caveat with that is, it only allows a single argument to be passed in, but does support all data types, so if you need multiple pieces of information you would most likely end up choosing to use a class or possibly a Map.

A common, albeit simple, use case one would run into where this is handy would be when making use of the FutureProvider, one of Riverpods built in providers for dealing promises, like network requests..

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_7.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_7.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_7.jpg">
  </picture>
</p>

As you can see in this example we are passing in the ID, the first argument is the response type expected form the API call and the second being the ID being passed into the FutureProvider.

An implementation I personally make a lot of use of is the family extensions ability to control uniqueness

In order for a state's data to be unique, the last argument you pass in needs to be uniquely hashable, the easiest of which is often a string, which can be a unique name that you choose or as in the example above it would be an ID and in this case one coming down from the database.

The example comes from one of the use cases in our mobile application, the drivers task list, each item in the list shared the same business logic, needs to be able to perform the same actions/interactions, however naturally the data needs to be unique to each in order to ensure the correct data is displayed.

So using the task's unique ID, the notifier can be instantiated uniquely for each item in the list, ensuring that each of the tasks can access the logic but keep its own data.

# Accessing the Providers

## UI

Some of you may have noticed the two references to “ref” in the previous examples, similar to build context, that is how Riverpod accesses its providers, on the UI side you have a Widget Ref and within a Riverpod provider it is simply Ref.

For the UI side, we simply need to replace the StatelessWidget with the ConsumerWidget, which will then add the WidgetRef as the second argument on the build method, from there we have access to many of the same assessors we would use with Provider or BLoC/Cubit. There is also a StatefulConsumer widget as well as Hook version available in a separate package for those who make use of flutter_hooks

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_9.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_9.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_9.jpg">
  </picture>
</p>

## Classes

When it comes to accessing providers within a provider, it is even more straightforward, here you would always be using read, which is accessed from the Ref that is available to all riverpod providers.

In this example we are accessing one of our network providers and chaining methods onto that in order to fire off a set of API calls to update the status of the currently active task.

# ProviderScope

ProviderScope is a wrapper widget provided by RiverPod and it’s what provides it a lot of its secret sauce, Provider scope in the simplest of use cases wraps your main widget inside runApp. This is how Riverpod ensures that all providers are accessible app wide.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_10.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_10.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_10.jpg">
  </picture>
</p>

However, it also provides the ability to override providers, at this point the most likely reason for one to do this would be to setup providers that rely on things that need to start up first, one such example from our project is GooglePlaces, while it itself does not need any startup, our application makes use of flavours to allow for building against multiple environments, so there are also multiple sets of environment variables including the API keys needed for things like GooglePlaces.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_11.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_11.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_11.jpg">
  </picture>
</p>

In our core providers file, we set up a google places provider, with the intention of overriding it, hence the throw, this would only pose a problem if it were not being overridden at app startup.

Once the API keys are loaded up, which will happen before runApp, we will have the API key available, and on the provider itself, which is why it needs to be set up first, we can use the overrideWith method to add a proper instance of the Package with the API key required for it to function.

This is just one, pretty simple, use case, in our application we also use it for things like shared preferences and firebase, registering these with providers allows us to easily leverage that globally accessible feature of Riverpod, giving easy access to Firebase and Shared Preferences both in the UI and in widgets in a consistent manner, and the real reasoning behind the why will become much clearer next, when we talk about testing.

# Testing

Testing is probably one of my favourite reasons to use Riverpod, just for how simple it makes it.

Widget testing is where ProviderScope comes in once again

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_12.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_12.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_12.jpg">
  </picture>
</p>

PumpApp is an extension I make use of in all my applications, it allows me to easily wrap essential or boilerplate widgets around what is needing to be tested, in this case it's the ProviderScope with an optional list of overrides that can pass into the test, the actual one in the app also includes the MaterialApp, Scaffold and optional navigation observers.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_13.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_13.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_13.jpg">
  </picture>
</p>

If we take a look at these seemingly random excerpts from a test we can get a sense of what is going on, in this test we are verifying that the online indicator is visible when the device is online.

Our connectivity provider responsible for monitoring the devices internet connection is also a Riverpod Provider, so we simply mock that and ensure it returns true for the device being online.

Next you will see the pumpApp extension, and the second argument being the array of overrides that are being provided, as with GooglePlaces in the app startup, we call the overrideWith method to instead make use of the mocked provider, instead of the real instance which the widget would be referencing.

On the write is just a snippet of the override to show how it would differ when mocking a state value, when using StateNotifer to manage your widgets state.

The one last example I want to go through for testing has to do with external packages, while we never test those ourselves, we often have to use them and in some cases mocking those external packages can vary from easy to downright painful.

<p>
  <picture>
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_14.webp" type="image/webp">
      <source srcset="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_14.jpg" type="image/jpeg">
      <img src="https://raw.githubusercontent.com/RemeJuan/remelehane/main/files/devfest_2023/devfest_2023_14.jpg">
  </picture>
</p>

One that we use throughout our application is Firestore, we try and make the app as offline capable as possible so we do communicate directly with Firebase, so attaching the static instance from Firestore to a Riverpod provider both makes accessing Firestore on the UI and data sides easy and consistent, it also allows for easy mocking, for testing of the network operations or UI interactions that rely on the near real-time data provided by firebase.
