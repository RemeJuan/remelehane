---
stackbit_url_path: posts/handling-race-conditions-with-redux-thunk
title: Handling race conditions with redux-thunk
date: '2018-05-22T04:38:40.000Z'
excerpt: >-
  One very important feature included in many modern web applications is search, our users always need to be able to find something, recently I had to hook up a “real-time” search
tags:
  - react
  - racecondition
  - redux
template: post
---


![](https://cdn-images-1.medium.com/max/500/1*vuRVtzCDBnbF_YINN6uKRg.png)

One very important feature included in many modern web applications is search, our users always need to be able to find something, recently I had to hook up a “real-time” search powered by [_elastic search_](https://www.elastic.co)_,_ as the user types we start returning a short list of what is potentially the most relevant to what your typing.

To make results more relevant and useful we naturally limited the initial API call to only after the third character was entered and also [debounced the async dispatch](https://github.com/RemeJuan/debounce-redux-dispatch), so all of this works swimmingly and was easy enough to set up.

This is where potential problems begin to come in, even with a debounce we still have multiple calls that are likely to fire off and there is no way to control the order they return in, to ensure we have the correct results for the user, all we really care about is the last call that we made.

After some time spent sifting through googles results looking at the various other ideas users had come up with, the idea arose to use timestamps in order to filter out all but the last made call and in turn update the state with the desired result set.

This solution turned out to work pretty well and was relatively easy to set up with only minor changes needed to how you have already structured you actions/thunks and reducer.

**Action**

You need to set up a start action that includes a data payload, this will be used in the thunk for setting the time in the reducer for the start of the search query, in addition to success and error.


```
export const SEARCH_POST_START = 'SEARCH_POST_START';

export const searchPostNoResults = data => ({
 type: SEARCH_POST_NO_RESULTS, data,
});
```


**Thunk**

As for the thunk, all you should need to do is update it to include this new action before the API call begins.


```
export function search(searchQuery) {
 return async (dispatch, getState) => {
   const timestamp = Date.now();
   const startData = { searchText: searchQuery, timestamp };
   dispatch(searchPostStart(startData));
   try {
     const url = `
${URL}?searchQuery=${searchQuery}
`;
     const options = {};
     const response = await fetch(url, options);
     const json = await response.json();
     const success = { searchResults: json, timestamp };
     return dispatch(searchPostSuccess(success));
   } catch (error) {
     const err = { error: true, errorMessage: error };
     return dispatch(searchPostError(err));
   }
 };
}
```


In the above snippet, you will see at the start of the thunk we dispatch the start action which includes the search query as well as the current timestamp.

The same logic then applies to the success and error, each of them gains this timestamp from this instance of the call for later comparison in the reducer.

**Reducer**

The final piece happens here, firstly a small helper comes in which does a simple check on the incoming timestamps.


```
function actionIsValid(state, data) {
 return data.timestamp >= state.timestamp;
}
```


As you can see all it is doing is ensuring that the incoming timestamp is not older than the one stored in the current state.


```
export const initialState = {
  error: false,
  errorMessage: undefined,
  isSearching: false,
  searchResults: [],
  searchText: '',
  timestamp: undefined,
};

function actionIsValid(state, data) {
  return data.timestamp >= state.timestamp;
}

export default function searchReducer(state = initialState, action){
 const { type, data } = action;

 switch (type) {
   case SEARCH_POST_SUCCESS: {
     if (actionIsValid(state, data)) {
       return {
         ...state,
         ...data,
         isSearching: false,
       };
     }
     return state;
   }

  case SEARCH_POST_START:
    return {
      ...state,
      ...data,
      isSearching: true,
    };

  default:
    return state;
  }
}
```


I just included the start and success for brevity, you will see I am simply spreading the data object from the action dispatched from the thunk, which was set up with keys matching those in the reducer for error, searchResults, timestamp and based on the is ationIsValid helper you can determine if the state needs to be updated or not.

For a complete, and better-highlighted example, here is a complete [gist](https://gist.github.com/RemeJuan/540800f3d600e95c18f6dad183f4382e).

****

I hope you found this interesting, and if you have any questions, comments, or improvements, feel free to drop a comment. Enjoy your Flutter development journey :D

If you enjoyed it, a like would be awesome, and if you really liked it, a [cup of coffee](https://www.buymeacoffee.com/remelehane) would be great.

Thanks for reading.
