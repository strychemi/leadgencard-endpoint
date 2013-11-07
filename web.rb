require 'sinatra'

get '/' do
  "GET request"
  puts request.env["rack.input"].read
end

post '/' do
  "POST request"
  puts request.env["rack.input"].read
end
