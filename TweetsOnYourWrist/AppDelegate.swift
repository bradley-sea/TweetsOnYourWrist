//
//  AppDelegate.swift
//  TweetsOnYourWrist
//
//  Created by Bradley Johnson on 2/3/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  func application(application: UIApplication!, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]!, reply: (([NSObject : AnyObject]!) -> Void)!) {
  
   var identifier : UIBackgroundTaskIdentifier! //begin background task, recommended by apple so your app doesnt get terminated by the system for taking too long to complete the network task
   identifier =  UIApplication.sharedApplication().beginBackgroundTaskWithName("Hello", expirationHandler: { () -> Void in
    
    UIApplication.sharedApplication().endBackgroundTask(identifier)
      identifier = UIBackgroundTaskInvalid
    })
    
    //heres our actual task
      TwitterService.sharedInstance.fetchHomeTimeline({ (tweets, errorDescription) -> () in
        
        var items = [[String : NSObject]]()
        for tweet in tweets! {
          let info = ["text" : tweet.text, "user" : tweet.username]
          items.append(info)
          let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.TweetsOnYourWrist.CF")
          let imageURL = groupURL?.URLByAppendingPathComponent("\(tweet.username).png")
          let binaryImageData : NSData = UIImagePNGRepresentation(tweet.image) as NSData
          binaryImageData.writeToURL(imageURL!, atomically: true)
        }
        let replyInfo = ["items" : items ]
        reply(replyInfo)
        UIApplication.sharedApplication().endBackgroundTask(identifier)
        identifier = UIBackgroundTaskInvalid
      })
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   // var identifier : UIBackgroundTaskIdentifier!
    
//    identifier = UIApplication.sharedApplication().beginBackgroundTaskWithName("FetchHomeTweets", expirationHandler: { () -> Void in
//
//      let request = userInfo["request"] as String
//      //
//      let replyInfo = ["text" : "Hi"]
      
//      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//        reply(replyInfo)
//      })
      
      //UIApplication.sharedApplication().endBackgroundTask(identifier)
      
      
//      //      if request == "home" {
//              TwitterService.sharedInstance.fetchHomeTimeline({ (tweets, errorDescription) -> () in
//                let tweet = tweets?.first
//                //let replyInfo = ["text" : tweet!.text, "image" : tweet!.image!]
////                let replyInfo = ["text" : "Hi"]
////                reply(replyInfo)
//      
//                UIApplication.sharedApplication().endBackgroundTask(identifier)
//              })
//      //      }
//    })
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

