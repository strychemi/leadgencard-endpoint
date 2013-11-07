require 'sinatra'

get '/' do
  "GET request"
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end

post '/' do
  puts "POST start: " + request["name"] + " | " + request["email"] + " | " + request["screen_name"] + " | " + request["token"] + " | " + request["card"] + " | POST end"
end

