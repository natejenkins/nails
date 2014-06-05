module Nails
  class Controller
    attr_accessor :params
    attr_accessor :rendered
    attr_accessor :rendered_content
  
    def initialize
      self.rendered = false
    end

    def handle_request(method, params)
      self.params = params
      # puts "params: #{params}"
      res = self.send(method)
      if !rendered
        # puts "default rendering"
        render(method)
      else
        rendered_content
      end
    end

    def render(method)
      self.rendered = true
      view = method + ".html.erb"
      controller_name = self.class.to_s.sub("Controller", '').downcase
      view_path = File.join(Nails.application.config.view_dir, controller_name, view)
      if File.exists? view_path
        template = ERB.new(File.read(view_path))
        # puts "------------ RENDERING #{view_path} -----------"
        self.rendered_content = template.result(binding)
      else
        error = "Template missing: #{view_path}"
        puts error
        self.rendered_content = error
      end
    end
  end
end