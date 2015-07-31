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
    
    static func buttonTitle() -> UIFont {
        return Font.heading(20.0)
    }
    
    static func body(size:CGFloat) -> UIFont {
        return UIFont(name: "Swiss721LightCondensedBT", size: size)!
    }
    
    static func heading(size:CGFloat) -> UIFont {
        return UIFont(name: "AlternateGothicLT-No2", size: size)!
    }
    
    static func preferredFontForTextStyle(style:NSString) -> UIFont {
        var contentSize = UIApplication.sharedApplication().preferredContentSizeCategory
        var styleDictionary = Constants.FONT_SIZE_TABLE[style]
        var fontSize = styleDictionary![contentSize] as! CGFloat
        return UIFont.systemFontOfSize(fontSize)
    }
    
}

public class Colour {
    
    static let Yellow:UIColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 40.0/255.0, alpha: 1.0)
    static let DarkYellow:UIColor = UIColor(red: 155.0/255.0, green: 124.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let Blue:UIColor = UIColor(red: 33.0/255.0, green: 190.0/255.0, blue: 216.0/255.0, alpha: 1.0)
}

public class Styles {
    
    static func apply() {
        
        // nav bar colour
        UINavigationBar.appearance().barTintColor = Colour.Blue
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        
        // nav bar title font
        let attributes: [String:AnyObject] = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName : Font.heading(20.0)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        // back button font
        UIBarButtonItem.appearance()
            .setTitleTextAttributes([NSFontAttributeName : Font.buttonTitle()],
                forState: UIControlState.Normal)
    }
}

