#!/usr/bin/python3
"""Module defines function to query subscribers on a given subreddit"""
import requests


def number_of_subscribers(subreddit):
    """Function returns the total number of subscribers on a given subreddit
       Returns 0 if subreddit is invalid
    """
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/d_trex)"
    }
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code != 200:
        return 0

    data = response.json().get("data")
    return data.get("subscribers", 0)
