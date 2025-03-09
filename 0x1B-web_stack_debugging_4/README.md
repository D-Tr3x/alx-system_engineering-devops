# Web Stack Debugging #4 | 0x1B


## Overview
The 5th in the **Web Stack Degugging** series. This project focuses on debugginh and optimizing a web stack to handle high loads (up to `1096`).
The objective is to ensure that the server can manage 1000 concurrent connections (with `100` requests at a time) without fail.
For this project `Puppet` was used to adjust the server's configuration and ApacheBench to benchmark the performance improvements.


## Tasks

- **0. Sky is the limit, let's bring that limit higher**
  This task involves:
  - Modifying the Nginx configuration (`/etc/default/nginx`) to increase the connection limit.
  - Using Puppet manifest to automate the configuration change.
  - Restarting Nginx to apply changes
  - Re-verifying the fix by running ApacheBench (`ab -c 100 -n 2000 localhost/`) to ensure all requests succedd with `0` failures.