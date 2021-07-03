---
stackbit_url_path: posts/progressive-web-app-with-webpack
title: Progressive Web App with Webpack
date: '2017-11-21T16:41:40.400Z'
excerpt: Progressive Web App with Webpack
tags:
  - javascript
  - pwa
  - progressivewebapp
  - webpack
template: post
---


![Progressive Web App with Webpack](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/3iyxw5l0u9h1hqki52rz.png)

Depending on your web application, a progressive web app may not be essential, but it may be useful to some of your users. Going PWA allows your users to save a subset of your website directly on their mobile device to be able to use it off-line.

All you need to make this work is that you site is HTTPS, a manifest.json file and to register a service working within your current application. With a little bit of time these can quite easily be created manually, however I am going to focus purely on using webpack as a means of integrating it with your existing build process. Similar approaches can be used with gulp/grunt.

Once setup your site will register as a PWA and on supporting mobile devices/browsers, users will even be prompted to save your app to their home screen, effectively installing it.

What we going to configure is 2 small webpack plugins that will generate the service worker and manifest required for a PWA to be registers.

The service worker will configure how your PWA is to function, what assets and URL’s are to be cached and so on.

The manifest file provides additional instructions and theming to the application, this is the essential piece if you wish users to be prompted to save your application on their devices.

## Setup

To get started simply install 
`sw-precache-webpack-plugin`
 and 
`webpack-pwa-manifest`
.


```javascript
    npm i sw-precache-webpack-plugin webpack-pwa-manifest -D
    yarn add sw-precache-webpack-plugin webpack-pwa-manifest --dev
```


In your webpack prod/dist config you then simply require these new modules:


```javascript
    const SWPrecacheWebpackPlugin = require('sw-precache-webpack-plugin');
    const WebpackPwaManifest = require('webpack-pwa-manifest');
```

Optionally you can also define a PUBLIC_PATH variable, this is used as part of the ServiceWorker config caching your domain name for later use.


```javascript
    const PUBLIC_PATH = 'https://www.my-domain.com/';
```

## Service Worker config

Add a config similar to below at the end of your current webpack plugins array:


```javascript
    new SWPrecacheWebpackPlugin(
      {
        cacheId: 'my-domain-cache-id',
        dontCacheBustUrlsMatching: /\.\w{8}\./,
        filename: 'service-worker.js',
        minify: true,
        navigateFallback: PUBLIC_PATH + 'index.html',
        staticFileGlobsIgnorePatterns: [/\.map$/, /manifest\.json$/]
      }
    ),
```


As you can see it is pretty strait forward, only thing that really benefits from updating would the cacheId. Additional plugin options for more advanced usage or extra info can be found at SW Precache Webpack Plugin Github.

## Manifest config

Just like the service working, you include another plugin config at the bottom of your webpack plugins array, this will provide you all of your aesthetic options for the offline application.


```javascript
    new WebpackPwaManifest({
      name: 'My Applications Friendly Name',
      short_name: 'Application',
      description: 'Description!',
      background_color: '# 01579b',
      theme_color: '# 01579b',
      'theme-color': '# 01579b',
      start_url: '/',
      icons: [
        {
          src: path.resolve('src/images/icon.png'),
          sizes: [96, 128, 192, 256, 384, 512],
          destination: path.join('assets', 'icons')
        }
      ]
    });
```


Things to note…

short_name: This is the name underneath the icon, keep this under 12 characters long.

background_color, theme-color and theme_color are all part of theming options for your manifest. The 2 theme versions are for different browser support, those will be styling the address bar.

icons: here you can provide multiple objects in the array, useful if you wish to provide a different icons for iOS and Android. More details on that Webpack PWA Github.
I simply added in a singe set WPWA will generate icons at all the sizes provided in the sizes array and place then defined destination path.

## Output

One last thing to do before we finish up, you need to add a publicPath key to your existing output object and set it to the 
`PUBLIC_PATH`
 const defined earlier.


```javascript
    output: {
      // Snip
      publicPath: PUBLIC_PATH
    },
```


## Registering your worker

Now that your webpack is all setup, once final piece of code needs to be added to your project.

Within you applications main js file, you need to add in this Immediately Invoked Function.


```javascript
    (function () {
      if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('./service-worker.js', {scope: '/'})
        .then(() => console.log('Service Worker registered successfully.'))
        .catch(error => console.log('Service Worker registration failed:', error));
      }
    })();
```


This will check if the browser your visitor is using supports service workers, and if so registers your service-worker.js.

Your website, at least to some extent, will now be available offline and can be saved as a PWA on the users device, after their next visit.

If you run your build process now you should see a few icons as well as a service-worker.js and amanifest.[hash].json in your public/dist folder.

Google created a Chrome plugin that you can use to test your implementation, [Lighthouse](https://chrome.google.com/webstore/detail/lighthouse/blipmdconlkpinefehnmjammfjpmpbjk?hl=en).

![1*SwvS9fcfHIaCrrELv1AFgg.png](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*SwvS9fcfHIaCrrELv1AFgg.png)

Also in chrome developers tools > Audit you should be able to see both your service worker and manifest registered within their respective Application menu items.

Here is what the PWA’ of my own portfolio site’s initial screen looks like. As you can see the Blue theming. My Icon in the middle as applications name at the bottom.

![1*LBGKJsZ_JllM9eihTWf5sw.jpeg](https://cdn.jsdelivr.net/gh/RemeJuan/remelehane@master/uPic/1*LBGKJsZ_JllM9eihTWf5sw.jpeg)

[RemeJuan/progressive-web-app-starter](https://github.com/RemeJuan/progressive-web-app-starter)

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.

