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
  
  @IBOutlet weak var myUserImage: UIImageView!
  
  // pulling the twitter service info from the class.
  var myTwitterService : TwitterService!
  
  
  
  // the tweet we have selected from the main tableview.
  var mySelectedTweet : Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myUsernameLabel.text = self.mySelectedTweet.myUserName
    
    
    myRetweetLabel.text = self.myRetweetLabel.text
    println(self.myRetweetLabel.text)
    
    myTweetInfoLabel.text = self.mySelectedTweet.myTweetText
    
    myUserImage.image = mySelectedTweet.myUserImage
    
    // fetch the data for the tweet info object
    
    self.myTwitterService.fetchInfoFromTweet(self.mySelectedTweet.myID, completionHandler: { [weak self] (theRetweets) -> Void in
      if self != nil {
        self!.myRetweetLabel.text = theRetweets
        
      }
      
    })
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
