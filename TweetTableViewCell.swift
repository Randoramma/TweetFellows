//
//  TweetTableViewCell.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/2/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//
import UIKit

class TweetTableViewCell: UITableViewCell {
  
  // properties
  
  @IBOutlet weak var myUserLabel: UILabel!
  @IBOutlet weak var myRetweetLabel: UILabel!
  
  @IBOutlet weak var myUserImage: UIImageView!
  
  @IBOutlet weak var myTweetLabel: UILabel!
  
  
  // builds out the tvc from archive storage.
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
    // Initialization code
  }// awakeFromNib
  
  // allows the VC to
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
