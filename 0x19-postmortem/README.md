# POSTMORTEM (_on [Webstack Debugging #3](../0x17-web_stack_debugging_3)_)


## ISSUE SUMMARY

On 28th February 2025, from approximately ***07:35 PM to 08:11 PM (GMT+1)**, an outage occurred on an isolated Ubuntu 20.04 container running an Apache web server. During this period, all GET requests to the WordPress website returned a 500 Internal Server Error.
The root cause of this failure was a misconfigured file reference in wp-settings.php, where a required file was mistakenly referenced with an incorrect .phpp extension instead of .php. This syntax error caused WordPress to fail in loading a critical file, leading to the server error.


## TIMELINE (`GMT +1`)
* 07:35 PM: A GET request was sent.
* 07:36 PM: The server returned a `500 Internal Server Error` response.
* 07:27 to
  07:30 PM: Multiple GET requests were sent to confirm the issue.
* 07:30 PM: Initial system diagnostics began using strace and curl.
* 07:45 PM: An automated fix was prepared using Puppet.
* 07:50 PM: Apache restart was initiated.
* 08:11 PM: The issue was resolved, and GET requests returned a 200 OK response.


## ROOT CAUSE
At approximately **19:35 GMT +1**, the on-call debugger encountered an issue while running
```bash
curl -sI 127.0.0.1`
The HTTP response header displayed: `HTTP/1.0 500 Internal Server Error` the `curl` process was repeated carefully to confirm the fauly, yet the error persisted.
Once the major problem was verified, the following debugging processes were carried out:
1. Verified that Apache was running:
   '''bash
   systemctl status apache2
   ps aux | grep nginx
2. Ensured no other process was listening at port `80`
3. Ensured the web server was serving content located in `var/www/html/`.
4. Verified that `/etc/apache2/apache2.conf` existed and was correctly configured.
5. Used `tmux` to run `strace` on the `root` Apache process while sendng a request via curl, in another panel. The `strace` output gave no significant errors.
6. Repeated strace on the www-data Apache worker process. The output contained:
   `-1 ENOENT (No such file or directory)`
   _indicating that a required file was missing or incorrectly referenced_.
7. Searched `var/www/html/wp-settings.php` using Nano for incorrect file extensions.
   The line was located at Line 40:
   `require ABSPATH . WPINC . '/class-wp-paused-extensions-storage.phpp';`
   _The incorrect `.phpp` extension caused the script to fail._
8. The file extension was corrected from `.phpp` to `.php`
9. Restarted `Apache2`
   `systemctl restart apache2`.
10. Retested with `curl` and confirmed a `200 OK` response.
11. Wrote a Puppet script to automate the fixes.


## CORRECTIVE AND PREVENTATIVE MEASURES
This issue was due to an application-level configuration error rather than a web server failure. To prevent similar incidents in the future:
### Improvements:
* **Automated configuration validation** should be implemented before deploying changes.
* The **code review processes** should be enhanced to catch syntax errors in critical configuration files.
* Deploy a monitoring tool such as [Datadog](https://app.datadoghq.com/) to detect and alert on internal server errors in real time.

### Actionable Tasks:
* To implement the listed measures to reduce the risk of similar outages and ensure faster resolution times in the future.
