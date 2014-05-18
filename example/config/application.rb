module ExampleApp
  class Application < Nails::Application
    config.base_dir = File.expand_path("../../", __FILE__)
    config.config_dir = File.join(config.base_dir, "config")
    config.controller_dir = File.join(config.base_dir, "controllers")
    config.model_dir = File.join(config.base_dir, "models")
    config.view_dir = File.join(config.base_dir, "views")
    config.database_path = File.join(config.base_dir, "db/example.db")
  end
end