# -*- coding: utf-8 -*-
#
# Response:
# {
#   "endTime": "string",
#   "log": "string",
#   "numofSummarize": 0,
#   "numofTweets": 0,
#   "processTime": "string",
#   "query": "string",
#   "startTime": "string",
#   "tweets": [
#     {
#       "createdAt": "2017-02-26T12:42:20.870Z",
#       "score": 0,
#       "statusId": 0,
#       "text": "string",
#       "userId": 0,
#       "userName": "string",
#       "userProfileImageURL": "string",
#       "userScreenName": "string"
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
  req.url '/api/27/twitter-summarize/get'
  req.params['q'] = "Apitore"
  req.params['iter'] = 1
  req.params['num'] = 3
end

puts response.body["numofTweets"]
puts response.body["tweets"][0]["text"]
puts response.body["tweets"][0]["score"]
