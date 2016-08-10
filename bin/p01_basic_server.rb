require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write(env["PATH_INFO"])
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

# {"rack.version"=>[1, 3], "rack.errors"=>#>, "rack.multithread"=>true, "rack.multiprocess"=>false, "rack.run_once"=>false, "SCRIPT_NAME"=>"", "QUERY_STRING"=>"", "SERVER_PROTOCOL"=>"HTTP/1.1", "SERVER_SOFTWARE"=>"puma 3.6.0 Sleepy Sunday Serenity", "GATEWAY_INTERFACE"=>"CGI/1.2", "REQUEST_METHOD"=>"GET", "REQUEST_PATH"=>"/hi/there", "REQUEST_URI"=>"/hi/there", "HTTP_VERSION"=>"HTTP/1.1", "HTTP_HOST"=>"localhost:3000", "HTTP_CONNECTION"=>"keep-alive", "HTTP_CACHE_CONTROL"=>"max-age=0", "HTTP_UPGRADE_INSECURE_REQUESTS"=>"1", "HTTP_USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36", "HTTP_ACCEPT"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "HTTP_ACCEPT_ENCODING"=>"gzip, deflate, sdch", "HTTP_ACCEPT_LANGUAGE"=>"en-US,en;q=0.8", "HTTP_COOKIE"=>"_TodoApp_session=Q0hOZzdGZGh0cVA2OHBZOGRCdFcwY1FWenlKclE2c2dTdC93U2Z4VlBXRTducFNmMkZ3OGkvNXFsNnRER2R6M0RDeS9LQkNtWHpaTU1pQml2R21sUHdHTnpweWdwc2tEMkptYzJvaDZMbE5xS3JHOWN1MFp5UFdwVVZvQkpRei9NWkpGMVNNcHdDTFZSOUU0clZMYWtJTzk5ZGpCTS9uV25lTWJjdjFFQ09tck0zRmdzYjlrc2xwejdWeUVJM2RuRU0wUndJWElPU0lBazFHdHFzdWJvaVd4NzcwYzNSbDlsVm1HYjY4dXBNNE0vOTc4TDBCM1V4dFF5ODU0V0VVcy0tSnZsN1ExdWpjS3BhNlJGdnpOZEJkdz09--92f12b7a771ddcb9f66cf0485b113042e8668add", "SERVER_NAME"=>"localhost", "SERVER_PORT"=>"3000", "PATH_INFO"=>"/hi/there", "REMOTE_ADDR"=>"127.0.0.1", "puma.socket"=>#, "rack.hijack?"=>true, "rack.hijack"=>#, "rack.input"=>#, "rack.url_scheme"=>"http", "rack.after_reply"=>[], "puma.config"=>##, :Port=>3000}, {:log_requests=>false, :binds=>["tcp://0.0.0.0:3000"], :app=>#}, {:environment=>"development"}, {}], @defaults={:min_threads=>0, :max_threads=>16, :log_requests=>false, :debug=>false, :binds=>["tcp://0.0.0.0:9292"], :workers=>0, :daemon=>false, :mode=>:http, :worker_timeout=>60, :worker_boot_timeout=>60, :worker_shutdown_timeout=>30, :remote_address=>:socket, :tag=>"bin", :environment=>"development", :rackup=>"config.ru", :logger=>#>, :persistent_timeout=>20}>, @plugins=#>}
