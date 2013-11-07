require 'sinatra'

get '/' do
  "GET request"
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end

post '/' do
  puts "POST request start"
  puts request["name"]
  raw2 = request.body
  raw = request.env["rack.input"].read
  "request was: #{raw}"
  "request was: #{raw2}"
  puts raw2
  puts "POST request end"
end
