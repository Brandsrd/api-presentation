require 'sinatra'

set :port, 3002

USERS = []

get '/' do
  USERS.to_json
end

post '/' do
  USERS.push params
  params.to_json
end
