require "sinatra"
require "sinatra/reloader"
require 'http'
require 'json'

get("/") do

  # build the API url, including the API key in the query string
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["CURRENCY_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  @symbols = parsed_data.fetch("currencies").keys

  # render a view template where I show the symbols
   erb(:homepage)
end

get("/:first_currency") do

  @original_currency = params.fetch("first_currency")

  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["CURRENCY_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @symbols = parsed_data.fetch("currencies").keys

  erb(:first_currency)
end


  get("/first_currency/:second_currency") do
    @original_currency = params.fetch("first_currency")
    @converted_currency = params.fetch("second_currency")

    api_url = "http://api.exchangerate.host/list?access_key=#{ENV["CURRENCY_KEY"]}"
    raw_data = HTTP.get(api_url)
    raw_data_string = raw_data.to_s
    parsed_data = JSON.parse(raw_data_string)
    @symbols = parsed_data.fetch("currencies").keys


    erb(:conversion)
  end
