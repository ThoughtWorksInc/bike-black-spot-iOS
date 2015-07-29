//
//  Styles.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 29/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

public class Font {
    
    static func body(size:CGFloat) -> UIFont {
        return UIFont(name: "Swiss721LightCondensedBT", size: size)!
    }
    
    static func heading(size:CGFloat) -> UIFont {
        return UIFont(name: "AlternateGothicLT-No2", size: size)!
    }
}

public class Colour {
    
    static let Yellow:UIColor = UIColor(red: 255.0, green: 204.0, blue: 40.0, alpha: 1.0)
    static let Blue:UIColor = UIColor(red: 33.0/255.0, green: 190.0/255.0, blue: 216.0/255.0, alpha: 1.0)
}

public class Styles {
    
    static func apply() {
        UINavigationBar.appearance().barTintColor = Colour.Blue
        UINavigationBar.appearance().tintColor = Colour.Blue
        UINavigationBar.appearance().backgroundColor = Colour.Blue
        UINavigationBar.appearance().translucent = false
    }
}


