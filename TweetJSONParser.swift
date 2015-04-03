//
//  TweetJSONParser.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 3/31/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import Foundation

/*
This class will be used to find tweets and break them into the individual components
we want to append onto an array of tweet objects.

*/
class TweetJSONParser {
  
  //instantiate our class function / type method.
  class func tweetsFromJSONData (data : NSData) -> [Tweet] {
    
    // instantiate the array containing the tweet objects.
    var tweets = [Tweet]()
    // provide informative error outlet.
    var error : NSError?
    
    /*
    create a jsonObject by using the NSJSONSerialization class to try and downcast a JSON object to a tweet object if one is
    available. This josnObject is downcast to an array of dictionaries composed of  key : value (Strings : anyObjects)
    */
    if let jsonObject = NSJSONSerialization.JSONObjectWithData (data, options: nil, error:&error) as? [[String : AnyObject]] {
      
      // cycle through all the tweets in the json object array and pull out our relevent fields.
      for object in jsonObject {
        
        // downcast any JSON parameter labeled as "text" to our text string.
        if let text = object["text"] as? String {
          
          // downcast any JSON parameter labeled as "user" to our text string.
          if let userInfo = object["user"] as? [String : AnyObject] {
            // pull the id from the tweet object for a user.
            if let id = object["id_str"] as? String {
              
              if let username = userInfo["name"] as? String {
                
                // convert the strings text and user into a Tweet object.
                let tweet = Tweet(theTweetText: text, theUserName: username, theID: id)
                tweets.append(tweet)
              }
            } // id_str
          } // text to string (user) and append
        } // text to string (text)
      }// for loop
    } // serialization
    
    // return tweets array
    return tweets
  } // tweetsFromJSONData
}
