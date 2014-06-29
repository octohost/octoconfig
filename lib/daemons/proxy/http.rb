class Template
  def initialize(services, daemon, tag)
    @services = services
    @daemon = daemon
    @tag = tag
  end

  def render
    template_data = ""
    puts "Render the template here."
    services = @services.data
    services.each do |name,urls|
      # Check consul for #{k}/DOMAINS
      @domains = self.domains(name)
      unless @domains.nil?
        @urls = urls
        #template_data += self.combine
        puts "Render template for #{name}"
      else
        puts "No template for #{name}"
        next
      end
      # domains = `/usr/bin/consulkv get #{name}/DOMAINS`
      # unless domains.nil? || domains == ''
      #   @domains = domains.gsub(/,/, ' ')
      #   puts "Domains: #{@domains}"
      # else
      #   next
      # end
      #@urls = urls
    end
    puts template_data
  end

  def domains(name)
    domains = `/usr/bin/consulkv get #{name}/DOMAINS`
    unless domains.nil? || domains == ''
      return domains = domains.gsub(/,/, ' ')
    else
      return nil
    end
  end

  def combine()
    config = File.open("./lib/templates/#{@daemon}/#{@tag}.erb").read
    template = ERB.new(config)
    template.result
  end
end
