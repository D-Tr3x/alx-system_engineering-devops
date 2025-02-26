# API Advanced | 0x16

## Overview
This project helped me understand working with web APIs, the Reddit API.

## Tasks:

### 0. How many subs?
  Wrote a function `number_of_subscribers` that:
  - Accepts `subreddit` as its parameter
  - Queries the Reddit API to fetch the total number of subscribers for the given subreddit
  - Returns the total number of subscribers
  - Returns `0` if the subreddit is invalid

### 1. Top Ten
  Wrote a function `top_ten` that:
  - Takes `subreddit` as its only parameter
  - Queries the Reddit API to fetch the top 10 hottest posts for the given subreddit
  - Prints the titles of the top 10 (hottest posts) or
  - Prints `None` if the subreddit is invalid

### 2. Recurse it!
  Wrote a recursive function `recurse` that:
  - Accepts `subreddit` as its required parameter and
    `hot_list`, `after` and `count` as optional parameters
  - Recursively queries the Reddit API to fetch all hot posts for `subreddit`
  - Uses pagination (via the `after` parameter) to transverse through all pages of the results
  - Accumulates and returns a list of titles for all hot posts
  - Returns `None` if no results are found, or if the subreddit is invalid