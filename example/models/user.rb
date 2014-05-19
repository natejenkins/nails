require "sqlite3"

class User < Nails::Model
  has_many :post
end