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
  
  @IBOutlet weak var myRetweetCountLabel: UILabel!
  
  @IBOutlet weak var myTweetInfoLabel: UILabel!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
