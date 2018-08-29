# DVGM -- Usage and Security Analysis

## Introduction / Prerequisites

This exercise sheet is meant to be followed on a recent GNU/Linux installation
and makes use of the terminal. While all necessary commands are provided, a
basic understanding if its usage is still required.

In the following, we will use the Damn Vulnerable Grade Management (DVGM) app as
a training target. Before continuing, please familiarize yourself with the app
and ensure that it is listening on `http://$(hostname):3000`, where
`$(hostname)` is the host name of your machine as returned by the `hostname`
command. This is important because some scanners have problems when scanning
loopback addresses such as `localhost` and `127.0.0.1`.

If you need to fresh-up your Ruby knowledge, our small [Ruby Primer](ruby-primer.md)
might be a helpful companion.

## Questions / Challenges

The folder [exercises](exercises/) contains several exercises that illustrate both manual
exploration of DVGM and the use of tools such as [Brakeman](https://brakemanscanner.org/),
[Arachni](http://www.arachni-scanner.com/), and [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project)
for finding various security vulnerabilities in DVGM.