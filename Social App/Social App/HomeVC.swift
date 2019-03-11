//
//  ViewController.swift
//  Social App
//
//  Created by Ruslan Latfulin on 3/12/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let username = user!["username"] as? String
        let fullName = user!["fullname"] as? String
        let email = user!["email"] as? String
        let profileImage = user!["ava"] as? String
        
        usernameLbl.text = username
        fullNameLbl.text = fullName
        emailLbl.text = email
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
