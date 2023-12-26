class HttpResponse
  attr_accessor :status, :headers, :body

  def initialize(status, headers, body)
    @status = status
    @headers = headers
    @body = body
  end

  def to_s
    <<~HTTP_RESPONSE
      #{status_line}
      #{header}

      #{@body}


    HTTP_RESPONSE
  end

  private
  def status_line
    status_message = {
      200 => 'OK',
    }
    "HTTP/1.1 #{@status} #{status_message[200]}"
  end

  def header
    @headers.map { |key, value| "#{key}: #{value}" }.join("\r\n")
  end
end
