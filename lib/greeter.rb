require "erb"

#source: https://www.youtube.com/watch?v=MHYMObuEahc&t=92s

#class Greeter
#  def call(env)
#    [200, {}, ["Hello World!"]]
#  end
#end

class Greeter
  def call(env)
    @request = Rack::Request.new(env)
    case @request.path
      when "/" then Rack::Response.new(render("index.html.erb"))
      when "/change"
        Rack::Response.new do |response|
          response.set_cookie("greet", @request.params["name"])
          response.redirect("/")
        end
      else Rack::Response.new("Not Found", 404)
    end
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def greet_name
    @request.cookies["greet"] || "World"
  end

end
