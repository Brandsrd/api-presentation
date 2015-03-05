require 'dotenv'
require 'rest-client'
require 'json'
require 'twilio-ruby'
require 'trello'
require 'awesome_print'

# load './test.rb'

Dotenv.load

def geocoding_example
  response = RestClient.get "https://maps.googleapis.com/maps/api/geocode/json", {
    params: {
      address: "5 place Sainte Gudule, 1000 Bruxelles",
      key: ENV['GOOGLE_GEOCODE_KEY']
    }
  }

  ap JSON.parse(response)
end

def meetup_example
  response = RestClient.get 'https://api.meetup.com/2/rsvps', {
    params: {
      sign:    true,
      key:      ENV['MEETUP_KEY'],
      event_id: "220347299"
    }
  }

  array =  JSON.parse(response)["results"].map do |r|
    r["member"]["name"]
  end

  ap array
end

def trello_get_example
  response = RestClient.get('https://api.trello.com/1/boards/W62G6sWd', {
    params: {
      key:   ENV['TRELLO_KEY'],
      token: ENV['TRELLO_TOKEN'],
      cards: "all"
    }
  })
  ap JSON.parse(response)
end

def trello_post_example
  Trello.configure do |config|
    config.developer_public_key = ENV['TRELLO_KEY']
    config.member_token         = ENV['TRELLO_TOKEN']
  end

  Trello::Card.create({
    list_id: "54f88c5f06ad00e5ffe7d6d8",
    name: "Hello There",
    desc: "created from api"
  })
end

def twilio_example(to)
  twilio_client.account.messages.create(
    from: "+32460201157",
    to:   to,
    body: "Hey this is my message from Twilio using Ruby"
  )
end

def twilio_client
  Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTHTOKEN']
end
