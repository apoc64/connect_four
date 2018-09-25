# Connect Four

This Rails app is an implementation of the classic game. Users and game data are stored in a PostgreSQL database. The game board is created using CSS grid. Visitors can view high scores and log in or sign up. Users can play games, win trophies, and get on the high scores list. Admins can create trophies and delete users. The deployed app is here: https://serene-beach-52766.herokuapp.com/

## Ruby version
This app uses:

* Ruby 2.4.2
* Rails 5.2

## Setup
After cloning this project, run
```bundle install```
```rake db:create```
```rake db:migrate```

## Running the app
To run the app locally, run
```rails s```

Then visit localhost:3000 in your browser. This will allow you to sign up or login with a secure password. If you wish to create an admin, you can run.

```rails c```

Then from the Rails console, run
```User.create(name: 'bob', password: '1234', role: 'admin')```

## Testing
To run the test suite, run

```rspec```
