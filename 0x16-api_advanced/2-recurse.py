#!/usr/bin/python3
"""Function to query a list of all host posts titles for a given subreddit"""
import requests


def recurse(subreddit, hot_list=[], after=None, count=0):
    """
    Recursively queries the Reddit API
    and returns a list of the titles of all hot articles for `subreddit`

    Returns: None,
                   if no results are found for the given subreddit or
                   if the subreddit is invalid
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/d_trex)"
    }
    params = {
        "after": after,
        "count": count,
        "limit": 100,
    }
    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code != 200:
        return None

    data = response.json().get("data", {})
    after = data.get("after")
    count += data.get("dist", 0)

    posts = data.get("children", [])
    for post in posts:
        title = post.get("data", {}).get("title")
        hot_list.append(title)

    if after:
        return recurse(subreddit, hot_list, after, count)
    return hot_list if hot_list else None
