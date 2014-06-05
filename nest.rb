# Script file I use to test out the Nails library
require 'pry'
require 'pry-nav'
load 'example/config/application.rb'

Nails.app.initialize!

Nails.app.handle_request("user/1/post/1")

## If you want to run a web server, uncomment the following
# Nails.app.run