//
//  UILabelExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by John Geddes on 28/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setBodyFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize)
    }
    
    func setHeadingFontSmall() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize)
    }
    
    func setHeadingFontLarge() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = UIFont(name: "AlternateGothicLT-No2", size: self.font.pointSize + 10)
    }
}