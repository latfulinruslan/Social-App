//
//  AppDelegate.swift
//  Social App
//
//  Created by Ruslan Latfulin on 1/30/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // image to be animated
    let backgroundImageView = UIImageView()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        backgroundImageView.frame = CGRect(x: 0, y: 0 , width: self.window!.bounds.height * 1.386, height: self.window!.bounds.height)
        backgroundImageView.image = UIImage(named: "background")
        self.window!.addSubview(backgroundImageView)
        
        moveBgLeft()
        
        return true
    }
    
    func moveBgLeft(){
        
        UIView.animate(withDuration: 45, animations: {
            self.backgroundImageView.frame.origin.x = -self.backgroundImageView.bounds.width + self.window!.bounds.width
        }) { (finished: Bool) in
            
            if finished {
                self.moveBgRight()
            }
        }
    }
    
    func moveBgRight() {
        UIView.animate(withDuration: 45, animations: {
            self.backgroundImageView.frame.origin.x = 0
            
        }) { (finished: Bool) in
            if finished {
                self.moveBgLeft()
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

