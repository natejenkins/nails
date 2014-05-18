reload!
require 'pry'
require 'pry-nav'
load 'example/config/application.rb'
# Nails.app.define_routes
# Nails.app.handle_request("user/1/post/1")
Nails.app.initialize!

Nails.app.run