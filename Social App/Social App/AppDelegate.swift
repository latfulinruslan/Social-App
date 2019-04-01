//
//  AppDelegate.swift
//  Social App
//
//  Created by Ruslan Latfulin on 1/30/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit
let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
let colorSmoothRed = UIColor(red: 255/255, green: 50/255, blue: 75/255, alpha: 1)
let colorLightGreen = UIColor(red: 40/255, green: 255/255, blue: 125/255, alpha: 1)

let fontSize12 = UIScreen.main.bounds.width / 31

var user: NSDictionary?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // image to be animated
    let backgroundImageView = UIImageView()
    
    var infoViewIsShowing = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        backgroundImageView.frame = CGRect(x: 0, y: 0 , width: self.window!.bounds.height * 1.386, height: self.window!.bounds.height)
        backgroundImageView.image = UIImage(named: "background")
        self.window!.addSubview(backgroundImageView)
        
        moveBgLeft()
        
        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
        //print(user)
        if user != nil {
            let id = user!["id"] as? String
            
            if id != nil{
                login(identifier: "tabBar")
            }
        }
        
        return true
    }
    
    func moveBgLeft(){
        
        UIView.animate(withDuration: 30, animations: {
            self.backgroundImageView.frame.origin.x = -self.backgroundImageView.bounds.width + self.window!.bounds.width
        }) { (finished: Bool) in
            
            if finished {
                self.moveBgRight()
            }
        }
    }
    
    func moveBgRight() {
        UIView.animate(withDuration: 30, animations: {
            self.backgroundImageView.frame.origin.x = 0
            
        }) { (finished: Bool) in
            if finished {
                self.moveBgLeft()
            }
        }
    }
    
    
    func infoView(message: String, color: UIColor){
        
        if !infoViewIsShowing {
            
            infoViewIsShowing = true
            
            //red backgroud
            
            let infoViewHeight = self.window!.bounds.height / 11
            let infoViewY = 0 - infoViewHeight
            
            
            let infoView = UIView(frame: CGRect(x: 0, y: infoViewY, width: self.window!.bounds.width, height: infoViewHeight))
            infoView.backgroundColor = color
            self.window!.addSubview(infoView)
            
            
            // show info text
            let infoLabelWidht = infoView.bounds.width
            let infoLabelHeight = infoView.bounds.height + UIApplication.shared.statusBarFrame.height / 2
            
            let infoLabel = UILabel()
            infoLabel.frame.size.width = infoLabelWidht
            infoLabel.frame.size.height = infoLabelHeight
            infoLabel.numberOfLines = 0
            
            infoLabel.text = message
            infoLabel.font = UIFont(name: "AvenirNext", size: fontSize12)
            infoLabel.textColor = .white
            infoLabel.textAlignment = .center
            
            infoView.addSubview(infoLabel)
            
            //animate errorView
            UIView.animate(withDuration: 0.2, animations: {
                infoView.frame.origin.y = 0
                
            }) { (finished) in
                
                if finished {
                    
                    UIView.animate(withDuration:  0.1, delay: 4, options: .curveLinear, animations: {

                        //move up errorView
                        infoView.frame.origin.y = infoViewY
                        
                    }, completion: { (finished) in
                        
                        if finished {
                            infoView.removeFromSuperview()
                            infoLabel.removeFromSuperview()
                            self.infoViewIsShowing = false
                        }
                    })
                    
                }
            }
        }
    }
    
    func login(identifier: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        window?.rootViewController = viewController
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

