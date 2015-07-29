//
//  UIViewControllerExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 29/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func setBackground() {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background.png")?.drawInRect(self.view.bounds)
        
        var backgroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
}

extension UIView {
    
    
    func setBackground() {
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(named: "background.png")?.drawInRect(self.bounds)
        
        var backgroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        self.backgroundColor = UIColor(patternImage: backgroundImage)
    }
}
