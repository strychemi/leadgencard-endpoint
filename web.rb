require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/lead'
require './models/card'

configure do
  # trying to see puts statements in heroku server logs
  $stdout.sync = true
end

# Inbound routes

get '/' do
  erb :index
end

get '/endpoint' do
  rc = process_input("GET", request)

  if (rc == true)
    erb :data_recd_200, :layout => nil
  else
    426
  end
end

post '/endpoint' do
    rc = process_input("POST", request)

    if (rc == true)
      erb :data_recd_200, :layout => nil
    else
      426
    end
end

# read from cache
get '/card/:id' do |card_id|

  data = $cache.get(card_id)

  string = ''

  unless data.kind_of?(Array) && data.length > 0
      string = "None found. Note that card data is not retained for longer than 5 minutes and is lost upon service restarts."
  end

  @records = data

  erb :card, :locals => { :card_id => card_id, :string => string }, :layout => :layout
end

# delete card
get '/delete/:id' do |card_id|
  data = $cache.get(card_id)

  if data.nil?
    string = 'Card data does not exist to delete.'
  else
    $cache.delete(card_id)

    erb :card, :locals => { :card_id => card_id, :string => string }, :layout => :layout
  end

end

get '/test403' do
    403
end

get '/test426' do
    426
end

# Error responses

error 403 do
  'Forbidden, SSL is required'
end

error 426 do
  'Bad Request, required lead generation parameters missing'
end

# write to cache
def write_to_cache(card_id, name, email, screen_name, tw_userId, token, method)

   data = $cache.get(card_id)
   unless data.kind_of?(Array)
       data = []
   end

   # this is a demo app, we have no need to keep the email we get, so let's just record if we think we got one
   email_found = (email.length > 5) ? "Yes" : "No"
   card = {"name" => name, "email" => email_found, "screen_name" => screen_name, "tw_userId" => tw_userId, "token" => token, "method" => method}

   data.push(card)

   $cache.set(card_id, data)
end

def process_input (method, request)
    # we always expect these fields
    # name, email, screen_name, user_id, token, card
    # TODO we could get custom fields, store those too
    name = request["name"] ? request["name"] : nil
    email = request["email"] ? request["email"] : nil
    screen_name = request["screen_name"] ? request["screen_name"] : nil
    tw_userId = request["tw_userId"] ? request["tw_userId"] : nil
    token = request["token"] ? request["token"] : nil
    card = request["card"] ? request["card"] : nil

    # puts statements for heroku logs
    puts name
    puts email
    puts screen_name
    puts tw_userId
    puts token
    puts card
    puts "INSPECTING REQUEST:"
    puts request.inspect

    if (name && email && screen_name && tw_userId && token && card)
        write_to_cache(card, name, email, screen_name, tw_userId, token, method)
        return true
    else
        return false
    end
end
