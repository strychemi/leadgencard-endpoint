require 'sinatra'

get '/' do
  "GET request"
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end

post '/' do
  "POST request"
  puts request["name"]
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end
