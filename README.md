# Insecure Grade Management - An Intentionally Vulnerable Rails Application

Insecure Grade Management is an **intentionally vulnerable** grade management application
that can be used for teaching *security testing* and *security programming*.

## Application Scenario

Insecure Grade Management implements a simplistic system for managing university grades.
Students can view their grades for their lectures. Moreover, students can add comments
to the grades that can be viewed by lecturers. Thus, the applications knows three roles:
*admins*, *lecturers*, and *students*.

* *Admins* can create new students, lecturers, and other admins. Admins can create
  new lectures, held by any lecturer. Admins can also create, view, and edit new
  grades for all lectures and students and can create, view, and edit comments.
* *Lecturers* can create new students. They can also create new lectures that are
  being held by them. Lecturers can can view grades for all students, but only enter
  new grades for their own students. Lecturers can see comments for all grades,
  but can not change any.
* *Students* can view their grades. For their convenience, they have the ability to filter
  their grade list by a lecturer name.

## Setup

### Dependencies

* Ruby 2.5 and bundler

### Installation

Make sure that you have `ruby` and `ruby-bundler` installed. Then, run the following in the grademgmt directory:

```bash
bundle install --path vendor/bundle
```

### Starting the server

To start the development server, run the following:

```bash
bin/rails server
```

## Team

* [Achim D. Brucker](https://www.brucker.ch/)
* [Michael Herzberg](http://www.dcs.shef.ac.uk/cgi-bin/makeperson?M.Herzberg)

## License

This project is licensed under the GPL 3.0 (or any later version).

SPDX-License-Identifier: GPL-3.0-or-later

## Master Repository

The master git repository for this project is hosted by the [Software
Assurance & Security Research Team](https://logicalhacking.com) at
<https://git.logicalhacking.com/BrowserSecurity/grademgmt>.
