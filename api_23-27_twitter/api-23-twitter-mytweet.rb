# -*- coding: utf-8 -*-
#
# Response:
# {
#   "endTime": "string",
#   "log": "string",
#   "numofTweets": 0,
#   "processTime": "string",
#   "query": "string",
#   "startTime": "string",
#   "tweets": [
#     {
#       "createdAt": "2017-02-26T12:35:09.881Z",
#       "favorited": true,
#       "favoritedCount": 0,
#       "retweetCount": 0,
#       "retweeted": true,
#       "sentiment": "string",
#       "sentimentScore": 0,
#       "source": "string",
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
  req.url '/api/23/twitter/mytweet'
  req.params['iter'] = 1
end

puts response.body["numofTweets"]
puts response.body["tweets"][0]["userScreenName"]
puts response.body["tweets"][0]["text"]
