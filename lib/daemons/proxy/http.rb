class Template
  def initialize(services, daemon, tag)
    @services = services
    @daemon = daemon
    @tag = tag
  end

  def render
    puts "Render the template here."
  end
end
