require 'sinatra'
require 'rest-client'
require 'json'

set :port, 3001

PROVIDER_BASE = 'localhost:3002'

get '/' do
  @users = JSON.parse RestClient.get PROVIDER_BASE
  erb :index
end

post '/create_user' do
  RestClient.post PROVIDER_BASE, params
  redirect '/'
end
