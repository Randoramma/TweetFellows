//
//  LoginService.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/1/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import Accounts
import Foundation

class LoginService {
  
  // Type method granting access to the ACAccount library.
  // We will return void and use a closure to capture the reference to our twitter account array asynchronously
  class func requestTwitterAccount (completionHandler : (ACAccount?, String?) -> Void) {
  
    // Reference account Store to allow us to access our twitter account feed.
    let theAccountStore = ACAccountStore ()
    
    // Return a twitter account type.
    let theAccountType = theAccountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    // Accessing the twitter account asynchronous call.
    // Running on a background thread.
    theAccountStore.requestAccessToAccountsWithType(theAccountType, options: nil) { (granted, error) -> Void in
      // if the call is granted and there are no connection errors.
      if granted && error == nil {
        // use optional binding to pull in an account array of type if present.
        if let theAccounts = theAccountStore.accountsWithAccountType(theAccountType) as? [ACAccount] {
          
          // if there is an available account of type
          if !theAccounts.isEmpty {
            // set that to our temporary account reference.
            let theTwitterAccount = theAccounts.first
            
            // this will be our return type fo the type method 
            completionHandler (theTwitterAccount, nil)
          }
        } // if let
        
        
        
      } else {
      
      // if there is not user account available.
      completionHandler (nil, "please sign into your twitter account")
      } // if granted && error
    } // requestAccessToAccountsWithType

  } // requestTwitterAccount
}