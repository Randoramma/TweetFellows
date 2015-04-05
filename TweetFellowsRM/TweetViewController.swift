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
  
  // create an instance of an imageService object to handle the image.
  let myImageService = ImageService()
  
  // table view in storyboard.
  @IBOutlet weak var myTableView: UITableView!
  
  
  // find the Nib in the bundle.
  let myNib = UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle())
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set the table data source to itself.
    
    self.myTableView.delegate = self
    // set tableView alpha to 0 to allow for transition.
    self.myTableView.alpha = 0
    
    self.myTableView.registerNib(myNib, forCellReuseIdentifier: "TweetCell")
    
    // use auto layout for row height.
    self.myTableView.estimatedRowHeight = 70
    self.myTableView.rowHeight = UITableViewAutomaticDimension
    self.myTableView.dataSource = self
    
    /*
    Use closure expression to login access to twitter account
    This code will be exceuted when ever ...login service needs to login into twitter.
    
    */
    LoginService.requestTwitterAccount { (theTwitterAccount, errorDescription) -> Void in
      // if a twitter account is found to exist on the device (see TwitterService)
      if theTwitterAccount != nil {
        // set
        TwitterService.mySharedService.myTwitterAccount = theTwitterAccount
        TwitterService.mySharedService.fetchHomeTimeline({ (theTweets, errorDescription) -> Void in
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
    } // viewDidLoad
    
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
    
    let cell = tableView.dequeueReusableCellWithIdentifier ("TweetCell", forIndexPath: indexPath) as TweetTableViewCell
    
    cell.tag++
    
    let tag = cell.tag
    // additional scrubbing of cell label contents when recycled.
    cell.textLabel?.text = nil
    // reset the images to nil because image load varibility times and image presence.
    cell.myUserImage.image = nil
    
    // set the identities for the tweets in the storyboards.
    if let theTweet = self.tweets?[indexPath.row] {
      cell.myTweetLabel.text = theTweet.myTweetText
      
      cell.myUserLabel.text = theTweet.myUserName
      
      // load and find image
      
      // set the image in the cell equal to the image from the dictionary.
      cell.myUserImage.image = theTweet.myUserImage
      
      if let theImage = theTweet.myUserImage {
        // set the cell's image equal to a temp variable.
        cell.myUserImage.image = theImage
        
      } else  {
        // lazy load the image if an image exists.
        self.myImageService.fetchProfileImage(theTweet.myUserImageURL!, completionHandler: {[weak self] (theImage) -> () in
          // if the cell still exists
          if self != nil {
            // set the cell's user image to myUserImage
            theTweet.myUserImage = theImage
            if tag == cell.tag {
              cell.myUserImage.image = theTweet.myUserImage
            }
          } // fetchProfileImage
        }) // callback
      } // if let else
    } // iflet tweet = self.tweets
    
    // reset the cell when the UIViewController has already been loaded.
    cell.layoutIfNeeded()
    return cell
  } // cellForRowAtIndexPath
  
  
  //MARK:
  //MARK: UITableViewDelegate
  // create a new UIViewController for to be used for when the row is selected.
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // instantiate a new view controller as type VC without segue.
    let theViewController = self.storyboard!.instantiateViewControllerWithIdentifier("myTweetInfoVC") as TwitterInfoViewController
    
    
    // pass to VC
    // mark the tweet that is to be passed into the VC.
    let theSelectedTweet = tweets![indexPath.row]
    
    // pass the tweet into the VC.
    theViewController.mySelectedTweet = theSelectedTweet
    
//    // pass the twitter service to the VC.
//    theViewController.TwitterService = self.myTwitterService
//    
    //
    self.navigationController?.pushViewController(theViewController, animated: true)
    
    
    
  } // didSelectRow
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
