//
//  ViewController.swift
//  Social App
//
//  Created by Ruslan Latfulin on 1/30/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    // UI objects
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var firstnameTxt: UITextField!
    @IBOutlet weak var lastnameTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func pushRegisterAction(_ sender: Any) {
        
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || emailTxt.text!.isEmpty || firstnameTxt.text!.isEmpty || lastnameTxt.text!.isEmpty {
            
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            firstnameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            lastnameTxt.attributedPlaceholder = NSAttributedString(string: "lastname", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            
        } else {
        
            let url = URL(string: "http://localhost/Twitter/register.php")!
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"
            
            let body = "username=\(usernameTxt.text!.lowercased())&password=\(passwordTxt.text!)&email=\(emailTxt.text!)&fullname=\(firstnameTxt.text!)%20\(lastnameTxt.text!)"
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error == nil {
                    DispatchQueue.main.async {
                        do {
    
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            let id = parseJSON["id"]
                            
                            if id != nil {
                                
                                UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                                user = UserDefaults.standard.object(forKey: "parseJSON") as? NSDictionary
                                
                                DispatchQueue.main.async {
                                    appDelegate.login()
                                }
                                
                            } else {
                                DispatchQueue.main.async {
                                    
                                    let message = parseJSON["message"] as! String
                                    appDelegate.infoView(message: message, color: colorSmoothRed)
                                }
                            }
                            
                        } catch {
                            DispatchQueue.main.async {
                                
                                let message = error as! String
                                appDelegate.infoView(message: message, color: colorSmoothRed)
                            }
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

