//
//  User.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/6/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import UIKit

/*
Our tweet object will be holding the text a user recieves.
The tweet will temporarily hold the username of the user sending the class.

*/
class User  {
  
  var myUserName : String
  
  
  // Instantiate the tweet object giving it user and text values.
  init (theUserName : String) {
    
    myUserName = theUserName
    
  }
  
}
