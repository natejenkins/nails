module Nails
  class Model
    def initialize(params={})
      params.each do |key, val|
        if self.class.method_defined? key
          self.send("#{key}=", val)
        end
      end
    end

    def self.inherited(base)
        #puts "inheriting from Nails::Model"
        base.db
        base.db_columns
        base.db.type_translation = true
        base.db.results_as_hash = true   
    end

    def self.load_db 
      SQLite3::Database.new Nails.application.config.database_path
    end

    def self.load_db_columns
      #puts "Loading db columns"
      columns = []
      
      #puts "TABLE_NAME: #{table_name}"
      db.query( "select * from #{table_name}" ) do |result|
        result.columns.each do |c| 
          columns += [c]
          self.send(:attr_accessor, c)
        end
      end

      columns
    end

    def self.db_columns
      @@db_columns = load_db_columns
    end


    def self.db
      @@db ||= load_db
    end

    def self.table_name
      name.downcase
    end

    def self.all(clause='')
      res = db.execute2("SELECT * FROM #{table_name}" + clause)
      # column_names = res[0]
      column_values = res[1..-1]
      column_values.map do |row|
        self.new(row)
      end
    end

    def self.find(id)
      res = db.execute2("SELECT * FROM #{table_name} WHERE id='#{id}'")
      res[1] && self.new(res[1]) || (puts "Could not find user with id=#{id}"; nil)
      
    end

    def self.has_many(*args)
      args.each do |model|
        model_name = model.to_s.capitalize
        define_method(model) do 
          clause = " WHERE #{self.class.table_name}_id='#{self.id}'"
          Object.const_get(model_name).send(:all, clause)
        end
      end
    end

    def save
      params = {}
      columns = self.class.db_columns 
      column_values = columns.map do |key|
        self.send(key)
      end

      column_string = columns.join(',')
      value_string = columns.map{|c| '?'}.join(',')
      s = "INSERT INTO #{self.class.table_name} (#{column_string}) values (#{value_string})"
      self.class.db.execute s, *column_values
    end
  end
end