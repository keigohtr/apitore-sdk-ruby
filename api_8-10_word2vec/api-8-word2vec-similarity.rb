# -*- coding: utf-8 -*-
#
# Response:
# {
#   "endTime": "string",
#   "log": "string",
#   "processTime": "string",
#   "similarity": 0,
#   "startTime": "string",
#   "word1": "string",
#   "word2": "string"
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
  req.url '/api/8/word2vec-neologd-jawiki/similarity'
  req.params['word1'] = "ポメラニアン"
  req.params['word2'] = "ゴールデンレトリバー"
end

puts response.body["log"]
puts response.body["similarity"]
