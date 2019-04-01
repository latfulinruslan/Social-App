//
//  LoginVC.swift
//  Social App
//
//  Created by Ruslan Latfulin on 1/31/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushLoginAction(_ sender: Any) {
        
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        } else {
            
            let username = usernameTxt.text!.lowercased()
            let password = passwordTxt.text!
            
            let url = URL(string: "http://localhost/Twitter/login.php")!
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            
            let body = "username=\(username)&password=\(password)"
            //print(body)
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            return
                        }
                        
                        print(parseJSON)
                        
                        let id = parseJSON["id"] as? String
                        if id != nil {
                            //
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            user = UserDefaults.standard.object(forKey: "parseJSON") as? NSDictionary
                            
                            DispatchQueue.main.async {
                                appDelegate.login(identifier: "tabBar")
                            }
                        } else {
                            //
                            DispatchQueue.main.async {
                                
                                let message = parseJSON["message"] as! String
                                appDelegate.infoView(message: message, color: colorSmoothRed)
                            }
                            
                        }
                    } catch {
                        DispatchQueue.main.async {
                            
                            let message = error.localizedDescription
                            appDelegate.infoView(message: message, color: colorSmoothRed)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        
                        let message = error!.localizedDescription
                        appDelegate.infoView(message: message, color: colorSmoothRed)
                    }
                }
            }).resume()
            
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
