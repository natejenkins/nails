module Nails
  class Router
    def url_reg_exp(url)
      '\A' + url.gsub(/:(\w+)/){"(?<#{$1}>\\d+)" } + '\z'
    end
    def get(url, options)
      controller, method = options[:to].to_s.split('#')
      @route_table += [["get", url_reg_exp(url), controller, method]]
    end

    def post(url, options)
      controller, method = options[:to].to_s.split('#')
      @route_table += [["post", url_reg_exp(url), controller, method]]
    end

    def clear()
      @controller = nil 
      @method = nil
      @route_table = []
    end

    def draw(&block)
      puts "clearing"
      clear()
      puts "calling block"
      instance_exec(&block)
      puts "finished"
    end

    def initialize()
      @controller = nil 
      @method = nil
      @route_table = []
    end

    def params_from_match(match)
      params = {}
      match.names.each do |name|
        params[name] = match[name]
      end
      params
    end

    def route(url, method="get", params={})
      ### Would be nice if Ruby had an lchomp, or had a strip(char)
      method = method.downcase
      url = url.sub(/\A\//, '').chomp("/")
      @route_table.each do |r|

        if (method == r[0]) && (match = url.match(r[1]))
          return [r[2], r[3], params.merge(params_from_match(match))]
        end
      end
      puts "route: #{url} not found"
      nil

    end
  end # class Router
end # module Nails