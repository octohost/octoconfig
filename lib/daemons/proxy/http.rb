class Template
  def initialize(services, daemon, tag)
    @services = services
    @daemon = daemon
    @tag = tag
  end

  def render
    template_data = ""
    services = @services.data
    services.each do |name,urls|
      @domains = self.domains(name)
      unless @domains.nil?
        @urls = urls
        template_data += self.combine(name)
      else
        next
      end
    end
    return template_data
  end

  def domains(name)
    domains = `/usr/bin/consulkv get #{name}/DOMAINS`
    unless domains.nil? || domains == ''
      return domains = domains.gsub(/,/, ' ')
    else
      return nil
    end
  end

  def combine(name)
    template = "# ServiceName: #{name}\n"
    template = "upstream #{name} {\n"
    @urls.each do |url|
      template += "  server #{url.gsub(/http:\/\//, '')};\n"
    end
    template += "}\n"
    template += "server {\n  server_name #{@domains.chomp};\n  location / {\n    proxy_pass http://#{name};\n"
    template += "  }\n}\n"
    return template
  end
end
