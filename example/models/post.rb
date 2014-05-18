require "sqlite3"

class Post < Nails::Model
  attr_accessor :db
  #has_one :user

  def load_db
    database_path = Nails.application.config.database_path
    SQLite3::Database.new File.join(path, db_name)
  end
  def db
    @db ||= load_db
  end

  def all
    table_name = self.class.name.downcase

  end
end