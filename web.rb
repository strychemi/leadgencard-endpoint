require 'sinatra'

get '/' do
  "GET request"
  raw = request.env["rack.input"].read
  "request was: #{raw}"
end

post '/' do
  raw2 = request.body
  raw = request.env["rack.input"].read
  puts "POST request start : " + request["name"] + " : " + raw + " : " + raw2 + " : " + "POST request end"
#  puts request["name"]
#  "request was: #{raw}"
#  "request was: #{raw2}"
#  puts raw2
#  puts "POST request end"
end
