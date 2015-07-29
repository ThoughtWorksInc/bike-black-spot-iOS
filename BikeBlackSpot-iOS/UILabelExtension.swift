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
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize)
    }
    
    func setHeadingFont() {
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize)
    }
}