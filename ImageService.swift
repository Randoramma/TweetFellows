//
//  ImageService.swift
//  TweetFellowsRM
//
//  Created by Randy McLain on 4/3/15.
//  Copyright (c) 2015 Randy McLain. All rights reserved.
//

import UIKit

class ImageService {
  
  let imageQueue = NSOperationQueue()
  
  func fetchProfileImage(theUrl : String, completionHandler : (UIImage?) -> Void) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      // get JSON url
      if let theUrl = NSURL(string: theUrl) {
        // get image url
        if let theImageData = NSData(contentsOfURL: theUrl) {
          // get the image from the url and put into an image.
          if let theImage = UIImage(data: theImageData) {
            // move the callback to the main queue.
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(theImage)
            })
          }
        }
      }
    }
    //download the image
  }
}
