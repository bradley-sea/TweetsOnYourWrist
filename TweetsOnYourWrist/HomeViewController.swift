//
//  HomeViewController.swift
//  TweetsOnYourWrist
//
//  Created by Bradley Johnson on 2/3/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
  var tweets = [Tweet]()
  @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.dataSource = self
      self.tableView.rowHeight = UITableViewAutomaticDimension
      TwitterService.sharedInstance.fetchHomeTimeline { (tweets, errorDescription) -> () in
        self.tweets = tweets!
        self.tableView.reloadData()
      }
        // Do any additional setup after loading the view.
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    let tweet = self.tweets[indexPath.row]
    cell.tweetLabel.text = tweet.text
    cell.avatarImageView.image = tweet.image
    return cell
  }

}
