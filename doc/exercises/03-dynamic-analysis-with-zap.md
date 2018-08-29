# (Interactive) Dynamic Analysis: ZAP

In the following, we will use the OWASP Zed Attack Proxy (ZAP) for analyzing our
web application. First, we will use ZAP interactively, meaning that we will
manually use DVGM while all traffic is being routed through ZAP's proxy and
analyzed. Then, we will use the automatic features: *Spider* for discovering all
URLs in the app, *Active Scan* to get a fully automatic scan similar to
Arachni's, and the *Fuzzer* as a more manual, but also more powerful tool.
Finally, we will see how ZAP can be scripted using Python for a completely
automatic workflow for, e.g., continuous integration (CI) environments.

## Using ZAP as an interactive tool

Oftentimes, the Zed Attack Proxy is used passively with an automated test suite
to discover additional problems, but the proxy can also be used when browsing
the app interactively.

To begin, press the windows key, search for `ZAP`, and start the GUI of ZAP.
  Then, select *No, I do not want to persist this session at this moment in time*.

Now, in the top toolbar, click on the Chromium symbol (the right-most icon) to
start a built-in version of Chromium that is already configured to use the
proxy. Once the browser is started, enter `http://127.0.0.1:3000/` and press
enter (you can also use your hostname again, but ZAP does not require it).

Your previous attempts at hacking DVGM have been successful; you have been able
to obtain the login credentials of one of the lecturers (username: `achim`,
password: `sigmisinsecure`). Use them to log into the app, and browse around.
You will notice that you have more permissions now.

### Insecure Headers

You should notice that ZAP has been logging all visited URLs so far. Most of
them should have been tagged with an alert level of *Low* or *Medium*. Change
the current tab from *History* to *Alerts* to inspect the alerts in more detail.
Most of them should be related to insecure HTTP headers.

### Missing server-side validation

We will now tell ZAP to enable disabled form fields and also show form fields
that have been set to hidden. To do so, click the white light-bulb symbol in the
top toolbar.

Now, in the browser tab showing DVGM, go to the *Students* tab and try to create a
new student. You will notice that the form looks different now.

1. Can you create a new lecturer or even a new admin user? Try and see if you
  can log in with the new user.
2. What is the vulnerability here? Does it need to be fixed on the client or
  server side? Try and fix the vulnerability and test your fix.

Before you continue, make sure that you log out of DVGM. We will not continue with the lecturer account; a lecturer can create multiple kinds of resources in DVGM (grades, students), which leads the automated scanner not necessarily into infinite loops, but it will increase the scan time significantly. Do deal with these kinds of issues, one could limit the depth of the scanning further or even exclude these URLs.

## Using ZAP as an automated tool

We will now use the more automated functions of ZAP. Unlike previously, we will
directly use them with login credentials. ZAP offers to
automatically *steal* the authentication cookie of your interactive session and
use it for the automated functions.

To do so, click on the green plus next to the *Output* tab and open *HTTP
Sessions*. The table will most likely be empty, as ZAP by default checks all
cookies that come through the proxy for a small set of entries that resemble
sessions, which does not contain the one used by Ruby on Rails.

To add the cookie name to this set, click on the wheel in the top right corner
of the *HTTP Sessions* tab. Click on *Add...*, and add `user_credentials`.
Confirm the settings dialog with *OK*.

Now, log in as a *student*, using the credentials from *peter* (password:
*football*). You will notice that ZAP detected a new session (*Session 0*).
Right-click the session and set it to active. This will make sure that ZAP uses
the session for the scans.

### Spider

We will now use *Spider* to discover all URLs of our app, which is a
prerequisite for the automated scanner. In the top left window, right-click on
the URL and choose *Attack -> Spider...*. Click on *Start Scan* and observe the
output. Only URLs that are below the entry URL are scanned; all others are
skipped.

Before we start the scan, we want to exclude the *assets* and *sign_out* pages
again. *In the top left window*, right-click both entries and choose *Exclude
From -> Scanner*, and confirm with *OK*.

### Active Scan

To start the active scan, right-click on the URL in the top left window again
and choose *Active Scan...*. This will take a few minutes. Afterwards, in the
alert tab, you will see that ZAP now also found the two XSS vulnerabilities.

These alerts can also be exported into various formats. Do to so, click on
*Report* in the top bar. If you want to, have a look at a few generated reports.

### Fuzzer

We will now try to use ZAP's fuzzer to find the SQL Injection and XSS
vulnerabilities in the lecturer search bar.

To do so, select the *History* tab in ZAP. In DVGM, navigate to the *Grades* tab
and search for something that is easily recognizable, e.g., `FOOBAR`. After
pressing *Filter*, click on the new entry in ZAP's history tab.

In the top right part of the window, select *Request* to show the request that
you have just sent to the server. In the first line, select your search request,
e.g., `FOOBAR`, and right-click on the selection. Now, select *Fuzz...*, click
on *Payloads...* on the right, click *Add...*, select *File Fuzzers*, open the
*jprofuzz* sub-menu, and select *SQL Injection* and *XSS*. Confirm all dialog
boxes and click *Start Fuzzer*.

ZAP will now take the original request and replace `FOOBAR` with a number of
different payloads and are typically used for SQL Injections and XSS attacks.
Note that this mode is less automated than the *Active Scan*, so we will not get
alerts and a report from ZAP.

Instead, we will look for two things:

- *Reflected* in the *State* column means that ZAP, after having sent a specific
  payload for the *lecturer* parameter, found this particular token again in the
  HTML response from the server, which is an indicator that there *might* be a XSS
  vulnerability here.
- The HTTP status code in the *Code* and *Reason* columns can give a hint
  whether there is a SQL Injection in the app. A response code of 5xx indicates
  an internal server error, which might be due to a malformed SQL query as a
  result of the injection. This indicates that one can tamper with the structure
  of a SQL query, which often allows to arbitrary modification.

Before you proceed, close ZAP.

## Scripting ZAP

ZAP can also be controlled with a powerful python API. Many tasks that we have
just seen can therefore be automated and used as part of an automated testing
strategy. The following example shows how the *Spider* and *Active Scan* can be
started from python (without a user sesssion).

First, install the ZAP API:

```bash
pip3 install python-owasp-zap-v2.4
```

Then, start the ZAP in headless mode without a GUI:

```bash
/usr/share/zaproxy/zap.sh -daemon \
  -config api.key="dvgmisinsecure" \
  -port 8080
```

Finally, save the following python script somewhere and execute it:

```python
#!/usr/bin/env python
import time
from pprint import pprint
from zapv2 import ZAPv2

target = 'http://127.0.0.1:3000'
apikey = 'dvgmisinsecure'

# By default ZAP API client will connect to port 8080
zap = ZAPv2(apikey=apikey)

# Proxy a request to the target so that ZAP has something to deal with
print('Accessing target {}'.format(target))
zap.urlopen(target)
time.sleep(2) # Give the sites tree a chance to get updated

print('Spidering target {}'.format(target))
scanid = zap.spider.scan(target)

time.sleep(2) # Give the Spider a chance to start
while (int(zap.spider.status(scanid)) < 100):
    # Loop until the spider has finished
    print('Spider progress %: {}'.format(zap.spider.status(scanid)))
    time.sleep(2)

print ('Spider completed')

while (int(zap.pscan.records_to_scan) > 0):
      print ('Records to passive scan : {}'.format(zap.pscan.records_to_scan))
      time.sleep(2)

print ('Passive Scan completed')

print ('Active Scanning target {}'.format(target))
scanid = zap.ascan.scan(target)
while (int(zap.ascan.status(scanid)) < 100):
    # Loop until the scanner has finished
    print ('Scan progress %: {}'.format(zap.ascan.status(scanid)))
    time.sleep(5)

print ('Active Scan completed')

# Report the results
print ('Hosts: {}'.format(', '.join(zap.core.hosts)))
print ('Alerts: ')
pprint (zap.core.alerts())
```

This script is mostly taken from <https://github.com/zaproxy/zap-api-python/>,
where also a more sophisticated script can be found.
