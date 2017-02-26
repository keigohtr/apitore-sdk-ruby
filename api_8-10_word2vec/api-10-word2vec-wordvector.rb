# -*- coding: utf-8 -*-
#
# Response:
# {
#   "endTime": "string",
#   "log": "string",
#   "processTime": "string",
#   "startTime": "string",
#   "vector": [
#     0
#   ],
#   "word": "string"
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
  req.url '/api/10/word2vec-neologd-jawiki/wordvector'
  req.params['word'] = "犬"
end

puts response.body["log"]
puts response.body["vector"][0]
