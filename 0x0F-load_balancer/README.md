# 0x0F | Load Balancer


## Overview
In this project, I explored deeper **Load Balancing** and its configuration in web servers.

For **Task #1**, I wrote a Bash script that configures Nginx to include a custom HTTP response header on `web-01` and `web-02` servers; where
- the name of custom header must be `X-Served-By` and
- the value of the custom header must be the hostname.

For **Task #2**, I wrote a Bash script that installs and configures **HAProxy** on `lb-01` server, ensuring:
- traffic is distributed to `web-01` and `web-02`
- `round-robin` algorith is used for load balancing
- HAProxy can be managed through an init script
After configuration, HAProxy successfully balances incoming requests across both web servers.


## Tasks
- 0. Double the number of webservers
- 1. Install your load balancer
