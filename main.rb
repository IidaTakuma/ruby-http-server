require_relative 'src/server'

server = Server.new(port: 12345) do |request|

  body = { message: 'Hello world!' }.to_json
  header = {
    'Content-Type' => 'application/json',
    'Content-Length' => body.length
  }

  [200, header, body]
end

server.start
