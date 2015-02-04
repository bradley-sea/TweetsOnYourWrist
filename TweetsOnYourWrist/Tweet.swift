//
//  Tweet.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 1/5/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class Tweet {
  var text : String
  var username : String
  var imageURL : String
  var image : UIImage?
  var id : String
  var favoriteCount : String?
  var userID : String
  
  init( _ jsonDictionary : [String : AnyObject]) {
    self.id = jsonDictionary["id_str"] as String
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String : AnyObject]
    self.userID = userDictionary["id_str"] as String
    self.imageURL = userDictionary["profile_image_url"] as String
   self.username = userDictionary["name"] as String
    self.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.imageURL)!)!)
//    let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.TweetsOnYourWrist.CF")
//    let imageURL = groupURL?.URLByAppendingPathComponent("\(self.username).png")
//    println(imageURL)
  }
  
}
