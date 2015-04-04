//
//  TwitterService.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/1/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import Foundation
import Social
import Accounts


class TwitterService {
  
  
  class var sharedService : TwitterService {
    struct Static {
      static let instance : TwitterService = TwitterService()
    }
    return Static.instance
  }
  
  
  // properties
  // the user account information object.
  var myTwitterAccount : ACAccount?
  
  // string for home timeline http address (Twitter).
  let myHomeTimeline : String = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  
  // string to access the tweet info to pull into secondary VC.
  let tweetInfoURL  : String = "https://api.twitter.com/1.1/statuses/show.json?id="
  
  init () {
    // do nothing.
  }
  
  // function for accessing the Twitter home timeline.
  func fetchHomeTimeline (completionHandler : ([Tweet]?, String?) -> Void) {
    
    // temp constant for the url to be passed into the request method.
    let theRequestURL = NSURL(string: myHomeTimeline)
    
    // Perform the twitter request (Asynchronous method) to pull down the Json URL and place into the var.
    let theTwitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: theRequestURL, parameters: nil)
    
    // naming the account from twitter to our user account object.
    theTwitterRequest.account = myTwitterAccount
    
    // call the Twitter host and handle any errors produced by the request.
    theTwitterRequest.performRequestWithHandler { (theData, theResponse, error) -> Void in
      if error != nil {
        
      } else {
        
        var errorDescriotpon : String? = nil
        var theTweets = [Tweet]()
        switch theResponse.statusCode {
          
        case 200...299 : theTweets = TweetJSONParser.tweetsFromJSONData(theData)
          
        case 400...499 : println("user error, please try request again using valid query.")
          
        case 500...599 : println("server error, server own, please try again later.")
          
        default : println("non standard error")
          
        }
        
        // bring the twitter call back to the main queue.
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(theTweets, nil)
        })
        
        println(theTweets.count)
        
        
      } // if else
    } //performRequestWithHandler
    
  } // fetchHomeTimeline
  
  func fetchInfoFromTweet (theId : String, completionHandler : (String?) -> Void ) {
    
    // set the URL equal to the API's URL + the ID of the User.
    let tweetInfoURL = self.tweetInfoURL + theId
    // temp constant for the url to be passed into the request method.
    let theRequestURL = NSURL(string: tweetInfoURL)
    
    // Perform the twitter request (Asynchronous method) to pull down the Json URL and place into the var.
    let theTwitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: theRequestURL, parameters: nil)
    
    // naming the account from twitter to our user account object.
    theTwitterRequest.account = myTwitterAccount
    
    //
    theTwitterRequest.performRequestWithHandler { (theData, theResponse, theError) -> Void in
      // TODO setup the response switch statement
      if theResponse.statusCode == 200 {
        // new JSON Data.
        let theInfo = TweetInfoJSONParser.tweetInfoFromJSONParser(theData)
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(theInfo)
        })
        
        
        
        
        
      }
      
    }
    
    
  }
  
}
