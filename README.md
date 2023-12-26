# Ruby HTTP Server

シンプルな 200 番のレスポンスが返せる機能のみ。

## 使い方

```ruby
require_relative 'src/server'

# Requestクラスのインスタンスを引数に
# [status_code, header, body]の配列を返すblockを処理の本体に渡す
server = Server.new(port: 12345) do |request|

  body = { message: 'Hello world!' }.to_json
  header = {
    'Content-Type' => 'application/json',
    'Content-Length' => body.length
  }

  [200, header, body]
end

server.start
```
