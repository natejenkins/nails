# Nails

Nails is a very simple web application framework in the spirit of Ruby on Rails, intended to be used as a learning tool (ie, don't even think of using this in production).  My goal in writing Nails was to understand some of the magic behind Ruby on Rails.  The result is a very small framework (5 files, 4 of which are under 100 lines of code) that handles the basic things that Rails handles without all of the additional complexity of a full-stack framework.  It has models back by a db, controllers, views, and url routing.

The example app will look totally familiar to anyone with Rails experience, and if you want to learn how routing works, look at lib/nails/router.rb, if you want to see how the models are built up from the db, look at lib/nails/model.rb.

If you don't have any Rails experience, Nails is probably not the right place for you to begin, you should first write a few Rails apps, and if you ever ask yourself, "I wonder how the controller figures out which model to use?" then you should take a look at Nails.


## Installation

Although Nails is technically a gem, it is really meant as a learning tool and the best
way to learn from it is to clone the repo:
    git clone https://github.com/natejenkins/nails

Then cd into the repo and

    bundle install

Initialize the example database:

    ruby example/db/init_db.rb

You can run the example application:

    cd example
    ruby db/init_db.rb
    rackup

This will start a server at http://localhost:9292.

You should then be able to visit http://localhost:9292/user/1

Or you can play around in the console:

    rake console
    load 'nest.rb'

Or run the tests:

    ruby test/router.rb

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
