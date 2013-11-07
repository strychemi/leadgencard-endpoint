require 'sinatra'

get '/' do
  "GET request"
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end

post '/' do
  request["name"]
  request["email"]
  request["screen_name"]
  request["token"]
  request["card"]
end
