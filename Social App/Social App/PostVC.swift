//
//  PostVC.swift
//  Social App
//
//  Created by Ruslan Latfulin on 4/2/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class PostVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var TextTxt: UITextView!
    @IBOutlet weak var CountLbl: UILabel!
    @IBOutlet weak var SelectedImage: UIImageView!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var PostButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextTxt.delegate = self
        
        TextTxt.layer.cornerRadius = TextTxt.bounds.width / 50
        PostButton.layer.cornerRadius = PostButton.bounds.width / 20
        
        self.automaticallyAdjustsScrollViewInsets = false

        
        PostButton.isEnabled = false
        PostButton.alpha = 0.4
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    @IBAction func PushPostButtonAction(_ sender: Any) {
        
        if !TextTxt.text.isEmpty && TextTxt.text.characters.count <= 140 {
            // post
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
         let numberofChars = textView.text.characters.count
        
        let spacing = NSCharacterSet.whitespacesAndNewlines
        
        CountLbl.text = String(140 - numberofChars)
        let text = textView.text
        if numberofChars > 140 {
            CountLbl.textColor = colorSmoothRed
            PostButton.isEnabled = false
            PostButton.alpha = 0.4
        } else if textView.text.trimmingCharacters(in: spacing).isEmpty{
            PostButton.isEnabled = false
            PostButton.alpha = 0.4
        } else {
            CountLbl.textColor = UIColor.lightGray
            PostButton.isEnabled = true
            PostButton.alpha = 1
        }
        
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
