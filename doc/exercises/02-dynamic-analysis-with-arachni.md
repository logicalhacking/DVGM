# Dynamic Analysis: Arachni

Arachni is a web application security scanner framework that supports many
different kinds of security checks, including detection of insecure header,
cross-site scripting (XSS), SQL injection, and cross-site request forgery
(CSRF). We will run the tool twice; first on the login page, then we will
provide the login credentials for a student to the tool -- otherwise, Arachni
would not see much beside the login screen, similar to an unauthenticated user.

## Running Arachni without credentials

In order to run Arachni, start it with the following options:

```bash
arachni --report-save-path=/tmp/sign_in_page.report \
  --check=unencrypted_password_forms,x_frame_options \
  --scope-exclude-pattern='/assets/|__web_console' \
  http://$(hostname):3000
```

To speed up the analysis, we only use the `unencrypted_password_forms` and
`x_frame_options` check, because this is the only one that will yield a result
at this point. If we would run Arachni with all checks enabled, it would take
considerably longer. In addition, by using `--scope-exclude-pattern`, we tell
Arachni to skip assets and the debug console of Ruby on Rails, which is active
since we run the app in development mode. Otherwise, Arachni will loop for a
long time trying to navigate the console.

Once the analysis is finished, inspect the report:
```bash
arachni_reporter \
  --reporter=html:outfile=/tmp/sign_in_page.html.zip \
  /tmp/sign_in_page.report 
unzip -d /tmp/sign_in_page /tmp/sign_in_page.html.zip
chromium /tmp/sign_in_page/index.html
```

Arachni should have found insecure headers and a possibly unsecured login page.
Remember that Arachni was acting as an unauthenticated user, so it is not
surprising that it found considerably less than brakeman.

### Insecure HTTP Headers

1. What is the purpose of the missing headers?
2. How could the lack of these headers be used to attack DVGM?
3. Ruby aims to have secure defaults. Can you find which part of DVGM's sorce
  is responsible for the lack of said headers?
4. We have now used a static analysis tool, Brakeman, and started to
  use a dynamic tool, Arachni. What are some benefits and limitations
  of these different kind of tools?

## Running Arachni with credentials

For the second run of Arachni, you will provide the login credentials for our
student account, `peter`. This will allow Arachni to scan more parts of DVGM.

```bash
arachni --report-save-path=/tmp/logged_in.report \
  --plugin=autologin:url="http://$(hostname):3000/sign_in",\
    parameters="user_session[login]=peter&user_session[password]=football",\
    check="| Logout" \
  --scope-exclude-pattern="sign_out|__web_console|/new" \
  --check=code_injection,csrf,'xss*',hsts,\
    unencrypted_password_forms,allowed_methods,x_frame_options \
  http://$(hostname):3000
```

Again, the scan might take a few minutes. This time, we use the `autologin`
plugin, which takes three parameters: `url`, the URL to the sign-in page;
`parameters`, which contains the POST parameters that a browser sends when we
type in username and password and submit the form; and `check`, which contains
text that Arachni uses to check whether the login succeeded (only when we are
logged in, we will find the text `| Logout` in the top bar).  Additionally, we
use more checks this time, because Arachni now has access to larger parts of our
app. We also need to make sure to exclude URLs from the scan that includes
`sign_out|`  (we do not want Arachni to log out automatically) or `/new|`'
(we do not want Arachni to end up in an infinite loop creating new grade
comments).

Once the scan finishes, inspect the report:

```bash
arachni_reporter \
  --reporter=html:outfile=/tmp/logged_in.html.zip \
  /tmp/logged_in.report
unzip -d /tmp/logged_in /tmp/logged_in.html.zip
chromium /tmp/logged_in/index.html
```

Arachni should have found XSS and CSRF vulnerabilites.

5. We ran Arachni with the `sql_injection` plugin. Recall the SQL exploit that
  you found earlier. What could be a reason for Arachni not finding the SQL
  injection vulnerability?

### DOM XSS / Client-Side XSS

6. Read through the two types of reported XSS issues. In
    particular, click on the eye button to inspect the injected seed
    along with the presented proof. Do you think the found issues
    are true positives? How does the automatic verification of the
    found XSS vulnerabilities work? How is the found XSS vulnerability different
    from the found DOM XSS vulnerability?

### Cross-Site Request Forgery (CSRF)

7. Inspect the found cross-site request forgery attack. The Ruby on Rails
  [Security Guide](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf)
  contains a good introduction to this kind of vulnerability. How can this kind of
  vulnerability be problematic found an app like DVGM? Compare the finding with
  the CSRF warning from Brakeman.