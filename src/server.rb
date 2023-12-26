require 'socket'
require 'json'
require_relative 'http_request'
require_relative 'http_response'

class Server
  def initialize(host: '127.0.0.1', port: 12345, &block)
    @host = host
    @port = port
    @block = block
  end

  def start
    begin
      listen_socket = Socket.tcp_server_sockets(@host, @port)[0] # IPv4 only
      puts "Server started on #{@host}:#{@port}"

      loop do
        socket = listen_socket.accept[0] # blocking
        process_on_sub_thread(socket)
      end
    end
  end

  private
  def process_on_sub_thread(socket)
    Thread.new(socket) do |socket|
      begin
        request = HttpRequest.new(socket)

        status_code, header, body = @block.call(request)
        response = HttpResponse.new(status_code, header, body)
        socket.write(response.to_s)
      end
    end
  end
end
