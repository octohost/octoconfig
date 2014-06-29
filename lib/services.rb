class Services
  def initialize()
    @data = Hash.new { |hash, key| hash[key] = [] }
  end
  def [](key)
    @data[key]
  end
  def []=(key,urls)
    @data[key] += [urls].flatten
    @data[key].uniq!
  end
  def get(command, service_type=http)
    stdout_str, stderr_str, status = Open3.capture3(command)
    stdout_str.each_line do |line|
      service = JSON.parse(line)
      unless service['ServiceTags'].nil?
        if service['ServiceTags'].include? service_type
          name = service['ServiceName']
          url = "http://#{service['Address']}:#{service['ServicePort']}"
          self[name] = %W( #{url} )
        end
      end
    end
  end
end
