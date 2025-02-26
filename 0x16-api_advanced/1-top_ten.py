#!/usr/bin/python3
"""Module defines function to print titles of hot posts on a given subreddit"""
import requests


def top_ten(subreddit):
    """
    Queries the Reddit API and
    prints the titles of the first 10 hot posts listed for the given subreddit
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/d_trex)"
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        print(None)
        return

    posts = response.json().get("data", {}).get("children", [])
    for post in posts:
        title = post.get("data", {}).get("title")
        print(title)
