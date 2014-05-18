require "sqlite3"
db_name = "example.db"
path = File.expand_path("../", __FILE__)
db_path = File.join(path, db_name)
File.delete db_path
db = SQLite3::Database.new File.join(path, db_name)

db.execute <<-SQL
CREATE TABLE user (
  id integer PRIMARY KEY AUTOINCREMENT, 
  name varchar(30)
  );
SQL

db.execute <<-SQL
CREATE TABLE post (
  id integer PRIMARY KEY AUTOINCREMENT, 
  title varchar(100),
  content text,
  user_id integer,
  FOREIGN KEY(user_id) REFERENCES user(id)
  );
SQL

### Populate the db with a few entries
["Bill", "Bob", "Jill", "Jane"].each do |name|
  db.execute "insert into user (name) values ( ? )", name
end

[
  {title: "First Post!!!", content: "This is the first post", user_id: 1},
  {title: "Second Post!!!", content: "This is the second post", user_id: 1},
  {title: "Another Post!!!", content: "from second user", user_id: 2},

].each do |post|
  db.execute "insert into post (title, content, user_id) values ( ?, ?, ? )", post[:title], post[:content], post[:user_id]
end
