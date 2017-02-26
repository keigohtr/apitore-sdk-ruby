# -*- coding: utf-8 -*-
#
# Response:
# {
#   "analogies": [
#     "string"
#   ],
#   "endTime": "string",
#   "log": "string",
#   "negatives": "string",
#   "num": "string",
#   "positives": "string",
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
  req.url '/api/8/word2vec-neologd-jawiki/analogy'
  req.params['positives'] = "日本 フランス"
  req.params['negatives'] = "パリ"
  req.params['num'] = 5
end

puts response.body["log"]
puts response.body["analogies"][0]
