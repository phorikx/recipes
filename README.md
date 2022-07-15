# README

This is an app in which users can add, store and edit recipes.

## Stack

This is meant as a practice app to get more familiar with the current Rails stack.

I plan to use Stimulus and Turbo to get a dynamic frontend, and to use the standard Rails 
setup for the backend.

## Getting Started

To get started with the app, clone the repo and then install the needed gems:

```
$ gem install bundler -v 2.3.14
$ bundle _2.3.14_ config set --local without 'production'
$ bundle _2.3.14_ install
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
