module Nails

  class << self

    def application
      @@application ||= nil
    end
    alias_method :app, :application

    def application=(application)
      @@application = application
    end
  end
  class Application
    attr_accessor :router
    class << self
      def inherited(base)
        puts "inheriting from Nails::Application"
        Nails.application = base.instance
      end

      def instance
        @@instance ||= new
      end

      def method_missing(m, *args, &block)  
        puts "There's no CLASS method called #{m} here -- please try again."
        instance.m(args, block)  
      end  

      def config
        instance.config
      end
    end

    def config
      @config ||= OpenStruct.new
    end

    def define_routes
      load(File.join(config.config_dir, "routes.rb"))
    end

    def load_controllers
      puts "loading controllers"
      load_directory(Nails.application.config.controller_dir)
    end

    def load_models
      puts "loading models"
      load_directory(Nails.application.config.model_dir)
    end

    def load_directory(dir)
      puts "loading directory: #{dir}"
      Dir.new(dir).each do |filename|
        if filename.match(/\A\./)
          next
        end
        puts "loading file #{filename}"
        load(File.join(dir, filename))
      end
    end

    def handle_request(url, method="get", params={})
      controller, method, params = router.route(url, method, params)
      if controller && method
        controller_path = File.join(config.controller_dir, controller + "_controller.rb")
        controller_name = controller.capitalize + "Controller"

        ### This is a bit of dynamic loading so that changes in the controller and model of the
        ### Route in question do not require a full server reload
        puts "loading controller: #{controller_name}"
        load(controller_path)
        model_path = File.join(config.model_dir, controller + ".rb")
        puts "loading model: #{model_path}"
        load(model_path)

        if Object.const_get(controller_name).method_defined?(method)
          eval(controller_name).new.handle_request(method, params)
        else
          "Undefined Method #{controller_name}\##{method}" 
        end
      else
        "No route matches #{method}: #{url}"
      end

    end

    def initialize()
      puts "initializing Nails::Application"
      @router = Nails::Router.new()
      @request_handler = lambda do |env| 
        url = env["REQUEST_PATH"].sub(/\A\//, '')
        params = {}
        puts "URL: #{url}"
        if env["REQUEST_METHOD"] == "POST"
          req = Rack::Request.new(env)
          params = req.params
        end
        [200, {"Content-Type" => "text/html"}, [handle_request(url, env["REQUEST_METHOD"], params) + "\n\n\n<br><br><br>" + "#{env}"]]
      end
    end

    def initialize!()
      define_routes
      load_controllers
      load_models
    end

    def run()
      Signal.trap('INT') {
        Rack::Handler::WEBrick.shutdown
      }
      Rack::Handler::WEBrick.run @request_handler
    end
    def method_missing(m, *args, &block)  
      puts "There's no method called #{m} here -- please try again."  
    end  
  end
end

