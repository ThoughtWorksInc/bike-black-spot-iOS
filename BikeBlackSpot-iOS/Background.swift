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
}