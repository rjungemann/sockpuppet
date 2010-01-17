module SockpuppetSocket
  def post_init
    puts "Sockpuppet: someone connected to the echo server!"
  end
  
  def receive_data data
    if(data.match /<policy-file-request\s*\/>/)
      puts "Sockpuppet: sending a cross-domain file."
      send_data %{<?xml version="1.0"?><cross-domain-policy><allow-access-from domain="*" to-ports="*"/></cross-domain-policy>\0}
    else
      request = RocketAMF.deserialize(data, 3)
      puts "Sockpuppet: sent \"#{request.inspect}\""
      
      response = { :message => "Hello, world!." }
      puts "Sockpuppet: sending \"#{response.inspect}\""
      
      send_data RocketAMF.serialize(response, 3)
    end
  end
end