//
//  TweetInfoJSONParser.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/3/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import Foundation

/*
Class dedicated to parsing data from the twitter object.

*/
class TweetInfoJSONParser {


  
  class func tweetInfoFromJSONParser (theData : NSData) -> String? {
    
    // create error object to store teh call back error if present.
    var myError : NSError?
    
    /*
    create a jsonObject by using the NSJSONSerialization class to try and downcast a JSON object to a tweet object if one is
    available. This josnObject is downcast to an array of dictionaries composed of  key : value (Strings : anyObjects)
    */
    if let theJSONTweetObject = NSJSONSerialization.JSONObjectWithData(theData, options: nil, error: &myError) as? [String : AnyObject] {
      
      // what is the text retweet count?
      if let retweetCount = theJSONTweetObject["retweetCount"] as? Int {
        return "\(retweetCount)"
      } // if let Retweet count
      
    } // if let NSSerialization

    return nil
  } // tweetInfoFromJSONParser
  
  
  
}
