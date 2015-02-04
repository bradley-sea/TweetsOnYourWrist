//
//  TweetCell.swift
//  TweetsOnYourWrist
//
//  Created by Bradley Johnson on 2/3/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var tweetLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
