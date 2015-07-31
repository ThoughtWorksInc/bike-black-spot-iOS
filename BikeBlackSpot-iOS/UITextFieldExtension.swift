//
//  UITextFieldExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by John Geddes on 28/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setBodyFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize)
    }
    
    func setHeadingFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize)
    }
    
    func setTitleFont() {
        self.font = Font.heading(20.0)
    }
}