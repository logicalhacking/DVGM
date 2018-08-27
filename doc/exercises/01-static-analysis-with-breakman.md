# Static Analysis: Brakeman

Brakeman is a static source code analyser for Ruby on Rails applications and can
be used at any stage of development, as it does not rely on any code being
executed. It finds many different types of security vulnerabilities. In the
following exercises, you will run Brakeman on DVGM and inspect three findings
more closely.

## Running Brakeman

Running Brakeman is simple. Navigate to the source code directory of DVGM and
call `brakeman` without any arguments.

Brakeman should return withing a few seconds and produce 7 security warnings. We
will have a closer look at the SQL Injection and Cross-Site Scripting findings.

### SQL Injection

Brakeman will report one possible SQL injection.

1. In which file and line is the possible SQL Injection located?
2. What action in what part of the app triggers the SQL query?
3. Is the vulnerability exploitable? If yes, write an exploit and test it.
4. If it is exploitable, how would a possible fix look like? Try the fix by
   changing the source code of DVGM (the changes are automatically picked up).
   See if your exploit still works. Do not forget to revert all changes afterwards,
   as we will also use other tools.

### Cross-Site Scripting (XSS)

Brakeman will report two possible cross-site scripting vulnerabilities *in DVGM
itself*. We will look more closely at the one that possibly affects logged-in
lecturers.

5. In which file and line is the possible XSS vulnerability located?
6. What action in what part of the app triggers the flagged line?
7. Is the vulnerability exploitable? If yes, write an exploit and test it.
8. If it is exploitable, how would a possible fix look like? Try the fix by
   changing the source code of DVGM (the changes are automatically picked up).
   See if your exploit still works. Do not forget to revert all changes afterwards,
   as we will also use other tools.

### Vulnerable Dependencies

Brakeman will also report (at least) two possible Cross-Site Scripting
vulnerabilities in dependencies.

 9. Which dependencies are affected?
10. Is DVGM likely to be affected by the reported CVEs?
