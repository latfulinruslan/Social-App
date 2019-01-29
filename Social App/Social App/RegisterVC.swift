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
            
        }
        
    }
    

}

