//
//  TwitterInfoViewController.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/3/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import UIKit

class TwitterInfoViewController: UIViewController {
  
  @IBOutlet weak var myUsernameLabel: UILabel!
  @IBOutlet weak var myTweetInfoLabel: UILabel!
  @IBOutlet weak var myRetweetLabel: UILabel!
  @IBOutlet weak var myUserImageButton: UIButton!
  
  // the tweet we have selected from the main tableview.
  var mySelectedTweet : Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myUsernameLabel.text = self.mySelectedTweet.myUserName
    
    myUserImageButton.setBackgroundImage(mySelectedTweet.myUserImage, forState: UIControlState.Normal)
    
    myRetweetLabel.text = self.myRetweetLabel.text
    println(self.myRetweetLabel.text)
    
    myTweetInfoLabel.text = self.mySelectedTweet.myTweetText
    
    // fetch the data for the tweet info object
    
    TwitterService.mySharedService.fetchInfoFromTweet(self.mySelectedTweet.myID, completionHandler: { [weak self] (theRetweets) -> Void in
      if self != nil {
        self!.myRetweetLabel.text = theRetweets
      }
    })
  }
  
  // MARK: - Navigation
//  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
//  // Get the new view controller using segue.destinationViewController.
//     Pass the selected object to the new view controller.
//  }
//  

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
