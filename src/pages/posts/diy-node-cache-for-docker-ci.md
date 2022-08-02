---
stackbit_url_path: posts/diy-node-cache-for-docker-ci
title: "DIY node_modules cache for Docker in your CI"
date: '2022-08-01T09:00:00.000Z'
excerpt: A custom solution for speeding up docker builds within your CI using a custom node_modules cache container.
tags:
  - node
  - docker
  - ci
  - node_modules
template: post
thumb_img_path: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/07/upgit_20220727_1658922123.webp
cover_image: https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/07/upgit_20220727_1658922123.webp
canonical_url: https://remelehane.dev/posts/diy-node-cache-for-docker-ci
---

![timelab-pro-yx20mpDyr2I-unsplash](https://raw.githubusercontent.com/RemeJuan/remelehane/main/2022/07/upgit_20220727_1658922123.webp)

## Background

While I am no DevOps expert, I have been working with CI tools for quite some time, and throughout my career, I have always aimed for optimal performance and efficiency both in my workflows and the products/web applications I build.

While this in no means is a perfect solution, and to be honest it may not be the best one, but it does work pretty well in my testing.

## Problem

Most applications we build today take as much advantage as possible/feasible of automated workflows. With everything from our testing, to deployments and more recently to some degree our code writing...

One problem I have seen is when it comes to building images for JS based web applications, things like Vue and React, personally I have worked with React for many years and previously working on Azure we had build times of around 12 minutes for our web applications, more recently I have been working with Google Cloud and am seeing times of around 10 minutes.

Now this is likely nothing to do with the CI tool, but to do with the size and complexity of the applications as much of this time is taken up by 1 common step, `npm install`, and given that this is an online action, many factors can influence how long this step takes.

## Solution (?)

Recently while walking my dog, I had this crazy idea of creating my own caching container for node, I am a big fan of using multi-stage builds and had just updated the project to take care of this, prior to that update we where shipping the base node image which builds to about 1.6GB, switching to multi-stage and shipping the alpine container got it down to 140mb.

While this idea is probably less viable, or at least beneficial for newer projects, older more mature and stables ones could see reasonable improvements with this idea.

---

---

It starts with creating a cache image, a simple image that builds with the required base node image, and simply installs the node modules, we then copy those over to an alpine image and we done.

```yaml
FROM node:18 as build

COPY package*.json ./

RUN npm install --no-audit --progress=false

FROM alpine as release

COPY --from=build /node_modules ./node_modules
```

This image becomes our "cache" image, and when in a more stable project, can be rebuilt weekly or even monthly as these package would be reasonably constant.

From there, one simply includes it as part of the build stages, as you will see from the first line `FROM node-cache as cache`, where `node-cache` is whichever name you provided to the image, which may need to include a reference to the container registry.

Do not forget that before this is used on a CI, the cache image does need to have been built and pushed to a container registry.

```yaml
FROM node-cache as cache

# Build Stage
FROM node:18 as build
COPY --from=cache /node_modules ./node_modules
COPY package*.json ./
COPY . ./
RUN npm install --no-audit --progress=false --prefer-offline
RUN npm run build

# Release stage
FROM node:18-alpine as release
# Copy files over from build stage
COPY --from=build /build ./build
COPY --from=build package*.json ./
COPY --from=build /server.js ./server.js

RUN npm install --only=production

CMD [ "npm", "run", "prod" ]
```

### Build Stage

This is where we make use of the cache, for this step we use the `node-18` image, the same image that was used as part of building the original cache image, and the key part of this is the line `COPY --from=cache /node_modules ./node_modules`, this line is copying the node modules folder from our cache into our build stage.

Doing this means we now have access to the relevant installed package, in a like environment, within our build stage. We then copy over the package files specifically followed by the remaining files in the directory.

It should also be noted that your project should include a `dockerignore` file, and `node_modules` should be specified in that file, otherwise the `COPY . ./` step would override the node_modules folder within the container.

Next we run the `npm install` step, the additional arguments can speed things up a bit, but the also specify that npm needs to check locally before checking online, this would ensure that only packages added, or upgraded, since the cache images last build would then be downloaded.

### Release Stage

If we take a look a bit further down at the release stage, the first few steps are to copy of the build directory (our compiled web app), the package.json file as well as the `server.js`.

The `server.js` is a small `express` server, allowing us to access our application held within the docker container, from the web.

```js
const http = require('http');
const Express = require("express");
const path = require('path');

const port = process.env.PORT || 7010;

const app = Express();
const server = http.createServer(app);

server.listen(port, function () {
    console.log(`Server listening on port ${port}`);
});

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname, "build", "index.html"));
});

app.use(Express.static(path.join(__dirname, "build")));

module.exports = server;
```

The second to last command is `RUN npm install --only=production`, that included flag instructs node to only install packages listed within the "dependencies" key of the `package.json`, ignoring anything in "devDependencies", so for this particular example, only `express` is being installed into the `alpine` image.

For this to work best, you need to ensure your `package.json` is split up correctly to ensure only required packages are listed as dependencies, all the rest should be devDependencies.

---

In my local testing, this resulted in an over 60% improvement in build times, with the average builds taking at least 150 seconds before this update, to under 50 seconds after.

In the pipeline, we saw a 40-45% improvement in build times, which would be as a result of images needed to be downloaded first.

For those who would like to take a further look, and even test out this solution, I have created a [REPO](https://github.com/RemeJuan/docker-cache-example) using the standard [CRA](http://create-react-app.dev), where you will find similar Docker files, and you can follow the steps in the readme to get things going.

---

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Also feel free to share a better solution if you have one :smile:

If you liked it, a like would be awesome.

Thanks for reading.

---

Wish to carry on with the topic of Unit Testing, take a look at:

- [Widget testing: Dealing with Renderflex Overflow Errors](https://remelehane.dev/posts/widget-testing-rendeflex-overflow/)
- [Flutter: Up your testing game](https://remelehane.dev/posts/up-your-testing-game/)

Photo by [Timelab Pro](https://unsplash.com/@timelabpro?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/container?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)
