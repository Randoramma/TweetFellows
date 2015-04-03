//
//  TweetViewController.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 3/31/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // properties
  
  // an array of tweet objects.
  var tweets : [Tweet]?
  
  @IBOutlet weak var myUserLabel: UILabel!
  // create an instance of the twitter account service.
  let myTwitterService = TwitterService()
  
  // table view in storyboard.
  @IBOutlet weak var myTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set the table data source to itself.
    
    self.myTableView.delegate = self
    // set tableView alpha to 0 to allow for transition.
    self.myTableView.alpha = 0
    
    // use auto layout for row height.  
    self.myTableView.estimatedRowHeight = 70
    self.myTableView.rowHeight = UITableViewAutomaticDimension
    self.myTableView.dataSource = self
    
    /*
    Use closure expression to login access to twitter account
    This code will be exceuted when ever ...login service needs to login into twitter.
    
    */
    LoginService.requestTwitterAccount { (theTwitterAccount, errorDescription) -> Void in
      println("we got accounts")
      // if a twitter account is found to exist on the device (see TwitterService)
      if theTwitterAccount != nil {
        // set
        self.myTwitterService.myTwitterAccount = theTwitterAccount
        self.myTwitterService.fetchHomeTimeline({ (theTweets, errorDescription) -> Void in
          if errorDescription != nil {
            // handle an error

            
          }
          
          // if tweets are present.  
          if theTweets != nil {
            // handle our tweets
            self.tweets = theTweets
            
            // reload the table view
            self.myTableView.reloadData()
          }
        })
        
      }
    }
    
    /*
    Use closure to animate the screen to allow for 1 second transition between frame updates
    */
    UIView.animateWithDuration(1.0, animations: { () -> Void in
      // reveal tableView through duration.
      self.myTableView.alpha = 1
    })
    }// view did load
  
     func viewWillAppear() {
      
    super.viewWillAppear(true)
      self.myTableView.reloadData()
  }
  
  //MARK:
  //MARK: UITableViewDataSource
  /*
  Import both numberOfRowsInSection and dequeueReusableCellWithIdentifier functions.
  */
  
  // Make 1 row for every tweet if any tweets are available.
  func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // assuming the array of tweets is not empty.
    if self.tweets != nil {
      // return the highest element in the array.
      return tweets!.count
    }
    return 0
  } // numberOfRowsInSection
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier ("myTableCell", forIndexPath: indexPath) as TweetTableViewCell
    // additional scrubbing of cell label contents when recycled.
    cell.textLabel?.text = nil
    
    // set the identities for the tweets in the storyboards.
    if let tweet = self.tweets?[indexPath.row] {
      cell.myTweetLabel.text = tweet.myTweetText
      
      cell.myUserLabel.text = tweet.myUserName

    }
    
    // reset the cell when the UIViewController has already been loaded.
    cell.layoutIfNeeded()
    return cell
  } // cellForRowAtIndexPath
  
  
  //MARK:
  //MARK: UITableViewDelegate
  // create a new UIViewController for to be used for when the row is selected.
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // instantiate a new view controller.
    let theViewController = UIViewController()
    
    // setup up the view controller.
    theViewController.view.backgroundColor = UIColor.whiteColor()
    
    self.navigationController?.pushViewController(theViewController, animated: true)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
