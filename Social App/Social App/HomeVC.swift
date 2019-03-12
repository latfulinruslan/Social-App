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
        
        if ava != "" {
            let imageURL = URL(string: ava!)!
            
            DispatchQueue.main.async {
                do{
                    let imageData = try Data(contentsOf: imageURL)

                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(data: imageData )
                            
                        }
                } catch {
                    DispatchQueue.main.async {

                        let message = error.localizedDescription
                        appDelegate.infoView(message: message, color: colorSmoothRed)
                    }
                }


            }
        }
    }
    
    let imagePicker = UIImagePickerController();
    
    @objc func selectImage(tapGestureRecognizer: UIGestureRecognizer){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let firstActionCamera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        alertController.addAction(firstActionCamera)
        
        let secondActionPhoto = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = false
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
    
    func createBodyWithParametrs(parametrs: [String:String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData{
        
        let body = NSMutableData()
        if parametrs != nil {
            for (key, value) in parametrs! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let fileName = "ava.jpg"
        
        let mimeType = "image/jpg"
        
        body.appendString(string:  "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(fileName)\r\n")
        body.appendString(string: "Content-Type: \(mimeType)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    func uploadAva() {
        
        let id = user!["id"] as! String
        
        let url = URL(string: "http://localhost/Twitter/uploadAva.php")!
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        let param = ["id" : id]
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let imageData = profileImage.image!.jpegData(compressionQuality: 0.5)
        
        if imageData == nil {
            return
        }
        
        request.httpBody = createBodyWithParametrs(parametrs: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
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
            } else {
                DispatchQueue.main.async {
                    
                    let message = error  as! String
                    appDelegate.infoView(message: message, color: colorSmoothRed)
                }
            }
        }).resume()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        profileImage.image = info[(UIImagePickerController.InfoKey.originalImage as NSString) as UIImagePickerController.InfoKey] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        uploadAva()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension NSMutableData {
    func appendString(string: String) {
        
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        append(data!)
        
    }
}
