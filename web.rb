require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/lead'
require './models/card'

configure do
  # trying to see puts statements in heroku server logs
  $stdout.sync = true
end

# Routes on the navbar
get '/' do
  erb :index
end

get '/test' do
  erb :test
end

get '/create-info' do
  erb :create_info
end

get '/leadgen-index' do
  status_message = nil
  @cards = Card.all
  erb :leadgen_index, locals: { cards: @cards, status_message: status_message }
end

get '/analytics' do
  @card_count = Card.all.count
  @lead_count = Lead.all.count
  @lead_per_card = @lead_count / @card_count
  erb :analytics, locals: { card_count: @card_count, lead_count: @lead_count, lead_per_card: @lead_per_card }
end

# routes that handle calls from Twitter Ads API
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

# retrieve lead gen card from database and render its list of leads
get '/card/:id' do |card_id|

  @card = Card.find_by_card(card_id)

  string = ''

  if @card.nil?
    string = "None found. A lead gen card with a card_id of #{card_id} doesn't live in this sample app database!"
  else
    leads = @card.leads
  end

  erb :card, :locals => { leads: leads, :card_id => card_id, :string => string }, :layout => :layout
end

# delete card
delete '/card/:id' do |card_id|
  status_message = nil
  @card = Card.find_by_card(card_id)

  if @card.nil?
    status_message = 'Card data does not exist to delete.'
  else
    if @card.destroy
      status_message = 'Card Successfully Deleted!'
    else
      status_message = 'Deletion of Card Failed!'
    end
    @cards = Card.all
    erb :leadgen_index, locals: { cards: @cards, status_message: status_message }
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

def process_input(method, request)
  # we always expect these fields (from Twitter Ads API)
  # name, email, screen_name, user_id, token, card
  # Feel free to setup custom fields via Twitter Ads and add them here
  name = request["name"] ? request["name"] : nil
  email = request["email"] ? request["email"] : nil
  screen_name = request["screen_name"] ? request["screen_name"] : nil
  tw_userId = request["tw_userId"] ? request["tw_userId"] : nil
  token = request["token"] ? request["token"] : nil
  card = request["card"] ? request["card"] : nil

  # puts statements for heroku logs
  puts name, email, screen_name, tw_userId, token, card
  puts "INSPECTING REQUEST:"
  puts request.inspect

  # check if we receive a all the info we need
  if (name && email && screen_name && tw_userId && token && card)
    # if so, check if the card exists in our database
    if Card.find_by_card(card).nil?
      if Card.create(name: name, card: card)
        puts "card created!"
      else
        puts "card didn't create!"
      end
    end
    # check if lead exists in our database
    if Lead.find_by_token(token).nil?
      if Lead.create(name: name, email: email, screen_name: screen_name, tw_userId: tw_userId, token: token, card_id: Card.find_by_card(card).id)
        puts "lead created!"
      else
        puts "lead didn't create!"
      end
    end
    return true
  else
    puts "Either we didn't get a card_id or the Card is already in the DB"
    # else, don't do anything and return false
    return false
  end
end
