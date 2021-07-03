---
stackbit_url_path: posts/vuejs-first-impressions-dao
title: 'VueJS: First Impressions'
date: '2017-11-21T16:34:21.955Z'
excerpt: >-
  With all the new libraries and frameworks it is pretty hard to keep up with
  all of them, and that i...
thumb_img_path: null
comments_count: 3
positive_reactions_count: 27
tags:
  - vue
  - frontend
  - javascript
  - webdev
canonical_url: 'https://dev.to/remejuan/vuejs-first-impressions-dao'
template: post
---


![1*nq9cdMxtdhQ0ZGL8OuSCUQ.jpeg](https://thepracticaldev.s3.amazonaws.com/i/gzic0j1dmzjhd0p2i727.jpeg)

With all the new libraries and frameworks it is pretty hard to keep up with all of them, and that is if you can even decide which ones are worth spending time one, over the last year or so I was exposed to many a new tech stack, with React for work and just personally playing around with React-Native, Aurelia and Angular2. Each of them attached to a new project, partly justified by wanting to try it out or form my own opinion.

Previously I had written about Aurelia, which I was very impressed with after than Angular 2 disaster, if you like, you can read more about it here:

[Aurelia: First impressions](https://medium.com/@reme.lehane/aurelia-first-impressions-e72262e6e049)

This time round I decided to dive into [Vue.JS](https://vuejs.org/), a lot of good things are being said about it on the web, with it apparently being faster than react, with it’s implementation of [Snabbdom](https://github.com/snabbdom/snabbdom), a simple and powerful Virtual DOM focused on performance. On top of that is is notably smaller than React sitting around 14kb.

Of all the frameworks and libraries I have worked with over the years, one thing that stood out to me about Vue.JS was the documentation, very detailed and easy to follow, covering multiple use cases and all the various options, where applicable, for each of it’s built in methods.

Now for a look at the code, the following example is for a very simple component, written in absolute bare-bones, just for you to get an idea of how things are structured.


```javascript
<template>
  <div>
    <header-bar></header-bar>
    <main>
      <search-bar :submit="search" :term="searchTerm"></search-bar>
        <list-data v-for="item in list" :event="item"></list-item>
    </main>
    <footer-bar></footer-bar>
  </div>
</template>

<script>
import Vue from 'vue';
import { Search } from './components';
import { Header, Footer, List } from '~/shared';
import './styles.scss';
export default {
  name: 'Events',
  components: {
    'header-bar': Header,
    'search-bar': Search,
    'list-data': List,
    'footer-bar': Footer,
  },
  data() {
    return {
      data: [],
      searchTerm: {},
    }
  },
  created() {
    // API/Service calls would go here
    return {
      data: [
        {},
        {}
      ],
    };
  },
  methods: {
    search() {
      // Search method written here
    },
  }
};
</script>
```


 
Vue.JS uses a template file containing both you template body and a script section, and these files are saved with a **.vue** extension.

Vue.JS itself is completely template agnostic, you can use handlebar/directive template as above, you can also use **JSX**, or even build it up very manually using es5 or es6 string interpolation if you prefer.

This file pretty much handles it all, you will define the HTML structure as well as relevant scripting logic, and either define a 
`<style>`
 block or import a style sheet like in the example.

The script tag is where all the real work begins, we start by importing Vue and whatever components we intend on using within the component.


```javascript
name: 'Events',
 components: {
    'header-bar': Header,
    'search-bar': Search,
    'list-data': List,
    'footer-bar': Footer,
 },
```


Above we have a snippet from the default export object, we start with the 
`components`
 name, followed by a components object. This object defines a key which is the tag name for the HTML element within our template with its value being the component we imported a little further up.

Next we have some of our methods to control initial logic and define usable functions.


```javascript
data() {
  return {
    data: [],
    searchTerm: {},
  }
},
```


The 
`data()`
 function is used to setup default data for initial rendering of the component, here the data key is setting itself as an empty array as later when we fetch the data it will become and array of objects, and we do not want to break the render by defaulting with invalid data types.


```javascript
created() {
  // API/Service calls would go here
  return {
    data: [
      {},
      {}
    ],
  };
},
```



`created()`
 is similar to reacts 
`componentWillMount`
 life cycle method, this is the best place within the life of the component to go fetch any data that is not available on initiation of the component, in this case to go fetch the actual list items.


```javascript
methods: {
  search() {
    // Search method written here
  },
}
```



`methods()`
 is where you define functions that will be used within the component itself, or passed down to a child component as props, as is the case with 
`search()`
, the child 
`Search`
 component will receive this method via the props, and this will then be fired off when a user interacts with the search component.

One thing that was not specifically included in the example but was was referenced was props, like react and probably many other libraries at this stage, Vue.JS also supports props, and like react they can be anything that a child component needs, be it static text, a function, and array of data needing to be looped over, or an object with key value pairs for simple dynamic display.

Props are quite simple to define, within the 
`default export`
 you would add another key, called ‘props’ with an array of all the props it is expecting to receive.



```javascript
<template>
  <form novalidate @submit.stop.prevent="submit">
    <label>Search term...</label>
    <input v-model="term.value"></input>
  </form>
</template>

<script>
export default {
  name: 'Search',
  props: ['submit', 'term'],
}
</script>
```


Above would then be an example of the search component, as you can see it is taking in 2 props, the submit method and term, which is a model for handling the search value that will be passed into the function.

This was just a taste of what is possible with Vue.JS, you will see many more examples by visiting their documentation at [Vue.JS docs](https://vuejs.org/v2/guide/).

If you wish to quickly spin up an application and start playing around with Vue.JS, I can suggest taking a look at the Yeoman generator created by [FountainJS](https://github.com/fountainjs/generator-fountain-vue).


Working with Vue.JS was a great pleasure, I found the learning curve very shallow, however that could purely be based on my experience, as mentioned before I have worked with a few in the past.

The default template structure feels very similar to how it was working with Angular, so developers coming from that background may pick it up a bit faster than they would react. I cannot really go un-learn react to see if it influences how easy it was to pick up Vue.JS.

Originally Posted on [Medium](https://hackernoon.com/vuejs-first-impressions-ef59822e94e6)

*[This post is also available on DEV.](https://dev.to/remejuan/vuejs-first-impressions-dao)*


<script>
const parent = document.getElementsByTagName('head')[0];
const script = document.createElement('script');
script.type = 'text/javascript';
script.src = 'https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/4.1.1/iframeResizer.min.js';
script.charset = 'utf-8';
script.onload = function() {
    window.iFrameResize({}, '.liquidTag');
};
parent.appendChild(script);
</script>    
