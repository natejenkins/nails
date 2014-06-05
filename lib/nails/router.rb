module Nails
  class Router

    def clear()
      @controller = nil 
      @method = nil
      @route_table = []
    end

    def initialize()
      clear
    end

    # A url in the router such as /user/:user_id/post/:post_id gets converted to a regular expression
    # where each param gets converted to a named group
    def url_reg_exp(url)
      '\A' + url.gsub(/:(\w+)/){"(?<#{$1}>\\d+)" } + '\z'
    end

    def add_route(verb, url, options)
      controller, method = options[:to].to_s.split('#')
      @route_table += [[verb, url_reg_exp(url), controller, method]]
    end

    def get(url, options)
      controller, method = options[:to].to_s.split('#')
      @route_table += [["get", url_reg_exp(url), controller, method]]
    end

    def post(url, options)
      controller, method = options[:to].to_s.split('#')
      @route_table += [["post", url_reg_exp(url), controller, method]]
    end

    # This is the magic behind routes.rb, and it is somewhat poorly named, but mirrors the name in the Rails Router
    # so that in an application's routes.rb file you can write:
    #   Nails.app.router.draw do 
    #     get "/", to: "static#home"
    #   end
    #  
    # which again mirrors a Rails app.
    # 
    # For those unfamiliar with instance_exec, it takes the block given in the routes.rb file and
    # executes it as if it were the body of a method defined in this class
    def draw(&block)
      clear()
      instance_exec(&block)
    end

    # Routes a url based on the @routing_table.  We pass in the params because on a post request,
    # there can already be a params hash but we still have to add relevant values from the url.
    def route(url, method="get", params={})
      method = method.downcase
      # Would be nice if Ruby had an lchomp, or had a strip(char)
      url = url.sub(/\A\//, '').chomp("/")
      @route_table.each do |r|
        if (method == r[0]) 
          if (match = url.match(r[1]))
            return [r[2], r[3], params.merge(params_from_match(match))]
          elsif (url == '')
            return [r[2], r[3], params]
          end
        end
      end
      puts "route: #{url} not found"
      nil
    end

    def params_from_match(match)
      params = {}
      match.names.each do |name|
        params[name] = match[name]
      end
      params
    end


  end # class Router
end # module Nails