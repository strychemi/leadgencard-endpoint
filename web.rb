require 'sinatra'

# required configure block for Memcached Cloud for the server cache
# Memcached is an in-memory key-value store for small chunks of arbitrary data
# (strings, objects) from results of database calls, API calls, or page rendering
# check out https://devcenter.heroku.com/articles/memcachedcloud for more info
configure do
    require 'dalli'

    if ENV["MEMCACHEDCLOUD_SERVERS"]
      servers = ENV["MEMCACHEDCLOUD_SERVERS"].split(',')
      username = ENV["MEMCACHEDCLOUD_USERNAME"]
      password = ENV["MEMCACHEDCLOUD_PASSWORD"]
    else
      servers = ['localhost:11211']
      username = nil
      password = nil
    end
    # hooks up memcached server to heroku or locally based on ENV vars using
    # via the Dalli Gem (https://github.com/petergoldstein/dalli)
    # which is a convenient Ruby client for accessing memcached servers
    $cache = Dalli::Client.new(servers, :username => username, :password => password, :expires_in => 300)
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
    #erb :error426
end

error Dalli::RingError do
  status 503
  erb :cache_503, :layout => :layout
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

    puts request

    if (name && email && screen_name && tw_userId && token && card)
        write_to_cache(card, name, email, screen_name, tw_userId, token, method)
        return true
    else
        return false
    end
end
