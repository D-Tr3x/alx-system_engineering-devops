# Web Stack Debugging #3 | 0x17


## Overview
This is the fourth in the the **Web Stack Debugging** series. In this project, I debugged a WordPress website running on an Apache server within a LAMP stack that was returning a `500 Internal Server Error`. I used tools such as `curl` and `strace` in separate `tmux` windows to trace the error.
Once identified, I autmated the fix using `Puppet` instead of `Bash` as done previously.


## Tasks
- **0. Strace is your friend**
In this task, I was to debug on my `Apache` returned a 500 error for the Wordpress website, after fixing the issue then automate using `Puppet` instead of `Bash` as done previously, then store the code in file: [0-strace_is_your_friend.pp](./0-strace_is_your_friend.pp)