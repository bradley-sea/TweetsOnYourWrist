//
//  InterfaceController.swift
//  TweetsOnYourWrist WatchKit Extension
//
//  Created by Bradley Johnson on 2/3/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

  @IBOutlet weak var table: WKInterfaceTable!
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
      
      InterfaceController.openParentApplication(["request" : "home"], reply: { (replyInfo, error) -> Void in
        let items = replyInfo["items"] as [[String : NSObject]]
        
        self.table.setNumberOfRows(items.count, withRowType: "TweetTableRowController")
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.TweetsOnYourWrist.CF")

        for (index, tweetInfo) in enumerate(items) {
          let row = self.table.rowControllerAtIndex(index) as TweetTableRowController
          let text = tweetInfo["text"] as String
          row.tweetLabel.setText(text)
          let user = tweetInfo["user"] as String
          row.userLabel.setText(user)
          let imageURL = groupURL?.URLByAppendingPathComponent("\(user).png")
          let imageData = NSData(contentsOfURL: imageURL!)
          let image = UIImage(data: imageData!)
           row.avatarImageView.setImage(image)
        }
      })
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
