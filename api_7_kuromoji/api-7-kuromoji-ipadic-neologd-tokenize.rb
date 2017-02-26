# -*- coding: utf-8 -*-
#
# Response:
# {
#   "endTime": "string",
#   "log": "string",
#   "processTime": "string",
#   "startTime": "string",
#   "tokens": [
#     {
#       "allFeatures": "string",
#       "allFeaturesArray": [
#         "string"
#       ],
#       "baseForm": "string",
#       "conjugationForm": "string",
#       "conjugationType": "string",
#       "known": false,
#       "partOfSpeechLevel1": "string",
#       "partOfSpeechLevel2": "string",
#       "partOfSpeechLevel3": "string",
#       "partOfSpeechLevel4": "string",
#       "position": 0,
#       "pronunciation": "string",
#       "reading": "string",
#       "surface": "string"
#     }
#   ]
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
  req.url '/api/7/kuromoji-ipadic-neologd/tokenize'
  req.params['text'] = "吾輩は猫である。名前はまだない。"
end

puts response.body["log"]
puts response.body["tokens"][0]["surface"]
puts response.body["tokens"][0]["allFeatures"]
