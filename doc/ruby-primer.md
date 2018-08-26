# DVGM -- Tips & Tricks

## Helpful Ruby (on Rails) Resources

- The official [Getting Started with Ruby on Rails guide](https://guides.rubyonrails.org/getting_started.html)
- The Ruby on Rails [Security Guide](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf)
- The [Ruby API search](https://apidock.com/rails/search)

## Structure of the DVGM Ruby on Rails Project

DVGM, like all Ruby on Rails projects, uses the Model-View-Controller (MVC)
paradigm, meaning it is decoupled into a view-part (handles the presentation to
the user), a controller-part (handles the business logic of the application),
and a model-part (handles the representation of the involved data and its
storage).

![Diagram of interactions within the MVC pattern.](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller#/media/File:MVC-Process.svg)

The most important folders in the DVGM project are:

Path                    | Description
----------------------- | ---
`app`                     | The main directory of the app
`app/assets/javascripts`  | This folder contains the CoffeeScript files that get compiled to JavaScript and sent with every page of the app.
`app/controllers`         | The app controllers that contain the business logic of the app.
`app/models`              | The model of the app. Ruby on Rails also automatically generates database tables from these files.
`app/views`               | The HTML template files. Some views exist in multiple versions, one for each role (student/lecturer/admin) in the app.
`db/development.sqlite3`  | The database that is used by DVGM. If you want to reset the state of the app, restore this file from the repository.

## Working with DVGM

The app can be started by using `bin/rails server`. This will use the development
mode, which uses a local SQLite3 as a database backend and will automatically
pick-up any changes you make to the source code, so there is no need to restart
the server.

If you want to reset the database (maybe because you found a SQL Injection and
dropped all tables ;)), you can restore `db/development.sqlite3` from the app source
code repository.

## Lightning-Quick Introduction to SQLite3 and SQL

SQLite3 is a file-base relational database. This means that all data is stored in
a single file, organized into rows and columns, where one data entry is represented
by one row. For example, one student grade in DVGM is stored like this:

```csv
id|lecture_id|student_id|grade|comment|created_at|updated_at
6|7|6|55|I guess I should have studied more...|2017-04-03 09:15:57.698459|2017-04-03 09:17:05.000330
```

This table only does not contain the name of the student, but only a reference
to them, as they are stored in a different table. Using SQL, we can look up the
student and lecture names, and only display the ones for for students whose names
start with a *P*:

```SQL
SELECT login,name,grade,comment FROM users JOIN grades JOIN lectures ON users.id=student_id AND lectures.id=lecture_id WHERE login LIKE 'P% ';
```

The output then will look like this:

```csv
login|name|grade|comment
Peter|Security|55|I guess I should have studied more...
Peter|Security|80|Doing the homework paid off!
```