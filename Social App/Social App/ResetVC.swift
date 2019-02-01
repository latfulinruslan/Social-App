//
//  ResetVC.swift
//  Social App
//
//  Created by Ruslan Latfulin on 2/1/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class ResetVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushResetAction(_ sender: Any) {
        
        if emailTxt.text!.isEmpty {
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        } else {
            
            let email = emailTxt.text!.lowercased()
            
            let url = URL(string: "http://localhost/Twitter/resetPassword.php")!
            let request = NSMutableURLRequest(url: url)
            
            request.httpMethod = "POST"
            
            let body = "email=\(email)"
            
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if error == nil {
                    
                    DispatchQueue.main.async {
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJSON = json else {
                                print("Error while parsing")
                                return
                            }
                            
                            print(parseJSON)
                            
                        } catch {
                            print("Caught an error \(error)")
                        }
                    }
                    
                } else {
                    print(error)
                }
            }.resume()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}
