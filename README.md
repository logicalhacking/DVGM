# Damn Vulnerable Grade Management (DVGM) - An Intentionally Vulnerable Rails Application

Damn Vulnerable Grade Management is an **intentionally vulnerable** grade
management application that can be used for teaching *security testing* and
*security programming*. It aims to be a small application with a realistic use
case that contains common vulnerabilities, making it a good target to get
started with automatic security testing tools.

## Known Vulnerabilities

VGM contains (at least) the following vulnerabilities:

* SQL Injection
* Cross-Site Scripting (XSS)
* DOM Based XSS / Client Side XSS
* Missing server-side input validation
* Insecure HTTP Headers

## Suggested Static and Dynamic Tools

We have tried many different tools to automatically find the vulnerabilities,
and found the following tools to work best for this kind of application. While
none of them finds all contained vulnerabilities, together they cover a
reasonable amount:

* [arachni (1.5.1)](https://github.com/Arachni/arachni)
* [zaproxy (OSWASP ZAP, 2.7.0)](https://github.com/zaproxy/zaproxy)
* [brakeman (4.2.1)](https://github.com/presidentbeef/brakeman)

## Application Scenario

Damn Vulnerable Grade Management implements a simplistic system for managing
university grades.  Students can view their grades for their lectures and add
comments to the grades, which can be viewed by lecturers. The application knows
three roles: *admins*, *lecturers*, and *students*.

* *Admins* can create new students, lecturers, and other admins. Admins can
  create new lectures, held by any lecturer. Admins can also create, view, and
  edit new grades for all lectures and students and can create, view, and edit
  comments.
* *Lecturers* can create new students. They can also create new lectures that
  are being held by them. Lecturers can can view grades for all students, but
  only enter new grades for their own students. Lecturers can see comments for
  all grades, but can not change any.
* *Students* can view their grades. For their convenience, they have the ability
  to filter their grade list by a lecturer name.

## Setup

### Dependencies

* Ruby 2.5 and [bundler](https://github.com/bundler/bundler)

### Installation

After cloning the repository, install the dependencies; `bundle` will install
all dependencies automatically into a project-local directory:

```bash
cd dvgm
bundle install --path vendor/bundle
```

### Starting the server

To make exploration of the app a bit easier, we run DVGM in development mode.
This means that 

* on errors, rails will return a detailed debug page, and
* changed source files will automatically be picked up, without needing to
  restart the server.

Now, start the server:

```bash
bin/rails server
```

Now, open your browser, go to <http://localhost:3000>, and start exploring!

## Team

* [Achim D. Brucker](https://www.brucker.ch/)
* [Michael Herzberg](https://www.mherzberg.de/)

## License

This project is licensed under the GPL 3.0 (or any later version).

SPDX-License-Identifier: GPL-3.0-or-later

## Master Repository

The master git repository for this project is hosted by the [Software
Assurance & Security Research Team](https://logicalhacking.com) at
<https://git.logicalhacking.com/BrowserSecurity/grademgmt>.
