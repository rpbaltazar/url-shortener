# README

## The requirement:

### Description

Build a small link shortener service with an API as well as a small web front-end.

* The link shortener should be able to receive a URL and give back a shortened URL.
* When a user accesses the shortened URL he should be redirected to the full URL.
* It should have an API endpoint where you can query stats around a particular shortened URL giving you details about the users that have visited the URL with as much information as you can get on that person.

### What we're looking for:

* We're not expecting brilliant looking apps, we're much more interested in functionality and process.
* We would love to see a git/svn repository with the history of how you built it (check-in early and often so we can see your thought processes).
* Document any major decisions you made or choices you took.
* Working code is preferred but non-functional with good testing and an explanation is also welcome.
* We are available to answer any questions you have about the requirements.

## Solution:

1. Clone the repository
2. Install dependencies
  1. The project assumes you're using RVM, so if not, make sure you install it before. Also, after installing it, and having it added to your bash (or zsh) configuration, make sure you've reloaded the configuration (by opening a new terminal or running `source ~/.zshrc`) and that you've reloaded the project path, to make sure rvm loads the proper settings.
  2. Install needed gems
  ```
  $ bundle install
  ```
3. Configure your `database.yml` file. There is a sample (`database.yml.sample`) that can be used as reference, but make sure to update it according to your local database configuration.
  1. Please note: `You don't (shouldn't) commit the database.yml file into the repository`
4. Run needed database configuration
```
$ rake db:setup
$ rake db:schema:load
```
5. Start the server
`$ rails s`
