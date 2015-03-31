//
//  Tweet.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 3/31/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import Foundation

/*
Our tweet object will be holding the text a user recieves.
The tweet will temporarily hold the username of the user sending the class.

*/
class Tweet  {
  
  let myTweetText : String
  
  let myUserName :String
  
  
  // Instantiate the tweet object giving it user and text values.
  init (theTweetText :String, theUserName : String) {
    
    myTweetText = theTweetText
    
    myUserName = theUserName
    
    
  }
  
}
