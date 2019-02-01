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
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}
