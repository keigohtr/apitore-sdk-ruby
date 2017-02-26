# -*- coding: utf-8 -*-
#
# Response:
# {
#   "distances": [
#     {
#       "distance": 0,
#       "word": "string"
#     }
#   ],
#   "endTime": "string",
#   "input": "string",
#   "log": "string",
#   "num": "string",
#   "processTime": "string",
#   "startTime": "string"
# }

require "rubygems"
require "faraday"
require "faraday_middleware"

conn = Faraday::Connection.new(:url => 'https://api.apitore.com') do |builder|
  builder.request :oauth2, "YOUR-ACCESS-TOKEN"
  builder.request :url_encoded
  builder.response :logger
  builder.response :json, :content_type => /\bjson/
  builder.adapter Faraday.default_adapter
end

response = conn.get do |req|
  req.url '/api/9/word2vec-neologd-jawiki/distance'
  req.params['word'] = "犬"
  req.params['num'] = 5
end

puts response.body["log"]
puts response.body["distances"][0]["word"]
puts response.body["distances"][0]["distance"]
