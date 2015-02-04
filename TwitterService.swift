//
//  TwitterService.swift
//  TweetsOnYourWrist
//
//  Created by Bradley Johnson on 2/3/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  var twitterAccount : ACAccount?
  var imageQueue = NSOperationQueue()
  
  class var sharedInstance : TwitterService {
    struct Static {
      static let instance : TwitterService = TwitterService()
    }
    return Static.instance
  }
  
  func fetchHomeTimeline( completionHandler : ([Tweet]?, String?) -> ()) {
    
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        if !accounts.isEmpty {
          self.twitterAccount = accounts.first as? ACAccount
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twitterRequest.account = self.twitterAccount
          twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            switch response.statusCode {
            case 200...299:
              
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                var tweets = [Tweet]()
                for object in jsonArray {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    let tweet = Tweet(jsonDictionary)
                    tweets.append(tweet)
                  }
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets, nil)
                })
              }
              
            case 300...599:
              completionHandler(nil, "this is bad!")
            default:
              println("default case fired")
            }
          }
        }
      }
      
    }
  }

  
  
  
}
