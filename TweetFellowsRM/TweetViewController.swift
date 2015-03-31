//
//  TweetViewController.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 3/31/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource {
  
  var tweets : [Tweet]?
  
  @IBOutlet weak var myTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set the table data source to itself. 
    
    self.myTableView.dataSource = self
    
    if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      
      if let data = NSData(contentsOfFile: filePath) {
        self.tweets = TweetJSONParser.tweetsFromJSONData(data)
      } //if let data
    }
  }// view did load
  
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
    
    
    let cell = tableView.dequeueReusableCellWithIdentifier ("myTableCell", forIndexPath: indexPath) as UITableViewCell
    // additional scrubbing of cell label contents when recycled.
    cell.textLabel?.text = nil
    
    if let tweet = self.tweets?[indexPath.row] {
      cell.textLabel?.text = tweet.myTweetText
    }

    return cell
  } // cellForRowAtIndexPath
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
