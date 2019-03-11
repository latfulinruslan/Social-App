//
//  TabBarVC.swift
//  Social App
//
//  Created by Ruslan Latfulin on 2/4/19.
//  Copyright © 2019 Ruslan Latfulin. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = .white
        
        //gray color
        let color = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        
        self.tabBar.barTintColor = UIColor(red: 45/255, green: 213/255, blue: 255/255, alpha: 1)
        
        self.tabBar.isTranslucent = false
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        
        for item in self.tabBar.items! as [UITabBarItem]{
        
            if let image = item.image {
                
                item.image = image.imageColor(color: color).withRenderingMode(.alwaysOriginal)
                
            }
        }
    }
    
    

}


extension UIImage {

    func imageColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
