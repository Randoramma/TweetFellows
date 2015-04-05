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
  
  @IBOutlet weak var myUserLocationLabel: UILabel!
  

  // find the Nib in the bundle.
  let myNib = UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle())
  
  
  // an array of tweet objects.
  var tweets : [Tweet]?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.myUserTableView.delegate = self
      
      
      self.myUserTableView.registerNib(myNib, forCellReuseIdentifier: "TweetCell")
      
      // use auto layout for row height.
      self.myUserTableView.estimatedRowHeight = 70
      self.myUserTableView.rowHeight = UITableViewAutomaticDimension
      self.myUserTableView.dataSource = self
      

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
