//
//  Background.swift
//  BikeBlackSpot-iOS
//
//  Created by Claire Dodd on 27/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

public class Background{
    public static func setBackground(callingView:UIViewController){
        UIGraphicsBeginImageContext(callingView.view.frame.size)
        UIImage(named: "background.png")?.drawInRect(callingView.view.bounds)
        
        var backgroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        callingView.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
    
    public static func setBackground(callingView:UIView){
        UIGraphicsBeginImageContext(callingView.frame.size)
        UIImage(named: "background.png")?.drawInRect(callingView.bounds)
        
        var backgroundImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        callingView.backgroundColor = UIColor(patternImage: backgroundImage)
    }
}