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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImage(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tap)

        let username = user!["username"] as? String
        let fullName = user!["fullname"] as? String
        let email = user!["email"] as? String
        let ava = user!["ava"] as? String
        
        usernameLbl.text = username
        fullNameLbl.text = fullName
        emailLbl.text = email
    }
    
    let imagePicker = UIImagePickerController();
    
    @objc func selectImage(tapGestureRecognizer: UIGestureRecognizer){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let firstActionCamera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        alertController.addAction(firstActionCamera)
        
        let secondActionPhoto = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        alertController.addAction(secondActionPhoto)
        
        if self.profileImage.image != UIImage(named: "defaultImageProfile") {
            let thirdActionDelete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) { (alert) in
                self.profileImage.image = UIImage(named: "defaultImageProfile")
            }
            alertController.addAction(thirdActionDelete)
        }
        
        let fourthActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alert) in }
        alertController.addAction(fourthActionCancel)
        
        present(alertController, animated: true, completion: nil)
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

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        profileImage.image = info[(UIImagePickerController.InfoKey.originalImage as NSString) as UIImagePickerController.InfoKey] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
