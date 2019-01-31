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
        }
    }
    
    
}
