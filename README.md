# outdoor.sy

A basic Ruby on Rails app that can import data from .txt files and save to a database.

1. After cloning the repository to your local machine,`cd` into the project directory and run `bundle install` to install required gems
2. Run `rake db:create`, `rake db:migrate`, `rake db:seed` to instantiate database
3. Log in with the user created by the seed file:
   Username: admin@outdoor.sy, Password: password
4. Batch upload users by attaching .txt files at the bottom of the page

---

Additional gems used:

- 'pg' for postgresql database
- 'Devise' for user authentication
- 'sass-rails' for .scss styling
- 'will_paginate' for pagination
