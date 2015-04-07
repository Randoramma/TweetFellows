//
//  TweetInfoJSONParser.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/3/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import UIKit

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
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(theData, options: nil, error: &error) as? [String : AnyObject] {
      if let retweetCount = jsonObject["retweet_count"] as? Int {
        return "\(retweetCount)"
      }
    }
    return nil
  } // tweetInfoFromJSONParser
}
