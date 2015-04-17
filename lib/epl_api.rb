# require all in /epl_api
Dir[File.dirname(__FILE__) + '/epl_api/*.rb'].each do |file|
  require file
end

module EplApi
  # Your code goes here...
end
