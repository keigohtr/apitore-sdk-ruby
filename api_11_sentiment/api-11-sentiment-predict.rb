# -*- coding: utf-8 -*-
#
# Response:
# {
#   "endTime": "string",
#   "log": "string",
#   "predict": {
#     "score": 0,
#     "sentiment": "string"
#   },
#   "processTime": "string",
#   "sentiments": [
#     {
#       "score": 0,
#       "sentiment": "string"
#     }
#   ],
#   "startTime": "string",
#   "text": "string"
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
  req.url '/api/11/sentiment/predict'
  req.params['text'] = "今日は晴れで気持ちがいい。"
end

puts response.body["log"]
puts response.body["predict"]["sentiment"]
puts response.body["predict"]["score"]
