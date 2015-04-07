  //
  //  UserTableViewController.swift
  //  TweetFellowsRM
  //
  //  Created by Randy McLain on 4/4/15.
  //  Copyright (c) 2015 Randy McLain. All rights reserved.
  //
  
  import UIKit
  
  class UserTableViewController: UITableViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var myUserTableView: UITableView!
    
    @IBOutlet weak var myUserBackgroundImage: UIImageView!
    
    @IBOutlet weak var myUserIDImage: UIImageView!
    
    @IBOutlet weak var myUserIDLabel: UILabel!
    
    var myLabelID : String!
    var myIDNumber : String!
    var myLocationID : String!
    var myUserImageURL : String!
    var myUserBackgroundImageURL : String!
    
    @IBOutlet weak var myUserLocationLabel: UILabel!
    
    
    // find the Nib in the bundle.
    let myNib = UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle())
    
    // Tweet Containing the relevant info for the user.
    var mySelectedUser : User!
    
    // an array of tweet objects from the user.
    var userTweets : [Tweet]?
    
    // create an instance of an imageService object to handle the image.
    let myUserImageService = ImageService()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      
      self.myUserIDLabel.text = myLabelID
      self.myUserLocationLabel.text = myLocationID
      
      println("the user id is " + self.myIDNumber)
      
      // set the table data source to itself.
      
      self.myUserTableView.delegate = self
      self.myUserTableView.registerNib(myNib, forCellReuseIdentifier: "TweetCell")
      
      // use auto layout for row height.
      self.myUserTableView.estimatedRowHeight = 70
      self.myUserTableView.rowHeight = UITableViewAutomaticDimension
      self.myUserTableView.dataSource = self
      
      if let theUserImage = myUserIDImage.image {
        self.myUserIDImage.image = theUserImage
      } else {
        self.myUserImageService.fetchProfileImage(myUserImageURL!, completionHandler: {[weak self](theUserImage) -> Void in
          // if the user image exists
          if self != nil {
            // set the cell's user image to myUserImage
            self?.myUserIDImage.image = theUserImage
          }
        })
      } //set the user Image
      
      if let theUserBackgroundImage = myUserBackgroundImage.image {
        self.myUserBackgroundImage.image = theUserBackgroundImage
      } else {
        self.myUserImageService.fetchProfileImage(myUserBackgroundImageURL, completionHandler: { [weak self](theUserBackgroundImage) -> Void in
          if self != nil {
            self?.myUserBackgroundImage.image = theUserBackgroundImage
          }
        })
      }
      
      // set
      TwitterService.mySharedService.fetchUserTimeLine(self.myIDNumber, completionHandler: { (theUserTweets) -> Void in
        // if tweets are present.
                if theUserTweets != nil {
                  // handle our tweets
                  self.userTweets = theUserTweets
        
                  // reload the table view
                  self.myUserTableView.reloadData()
                } else {
                  
                } //if else
      })
     } // viewDidLoad
    
    // Make 1 row for every tweet if any tweets are available.
    override func tableView (tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // assuming the array of tweets is not empty.
      if self.userTweets != nil {
        // return the highest element in the array.
        return userTweets!.count
      }
      return 0
    } // numberOfRowsInSection
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetTableViewCell
      
      cell.tag++
      // //////////////////////////////////////
      let tag = cell.tag
      // additional scrubbing of cell label contents when recycled.
      cell.textLabel?.text = nil
      // reset the images to nil because image load varibility times and image presence.
      cell.myUserImage.image = nil
      
      // set the identities for the tweets in the storyboards.
      if let theTweet = userTweets?[indexPath.row] {
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
          self.myUserImageService.fetchProfileImage(theTweet.myUserImageURL!, completionHandler: {[weak self] (theImage) -> () in
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
      
      // /////////////////////////////////////////////
      return cell
    } // tableView cellForRowAtIndexPath
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  }
