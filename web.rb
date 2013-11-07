require 'sinatra'

get '/' do
  "GET request"
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end

post '/' do
  puts "POST request start"
  puts request["name"]
  raw = request.env["rack.input"].read
  "request was: #{raw}"
  puts "POST request end"
end
