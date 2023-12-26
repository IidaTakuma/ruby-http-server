class HttpRequest
  attr_reader :method, :path, :version, :headers, :body

  def initialize(socket)
    parse_request(socket)
  end

  private
  def parse_request(socket)
    parse_request_line(socket)
    parse_headers(socket)
    parse_body(socket)
  end

  def parse_request_line(socket)
    request_line = socket.gets
    @method, @path, @version = request_line.split(' ')
  end

  def parse_headers(socket)
    @headers = {}
    while line = socket.gets
      break if line == "\r\n"
      key, value = line.split(':')
      @headers[key.downcase] = value.strip
    end
  end

  def parse_body(socket)
    @body = socket.read(headers['content-length'].to_i)
  end
end
