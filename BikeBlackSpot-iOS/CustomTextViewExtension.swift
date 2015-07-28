//
//  CustomTextViewExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by John Geddes on 28/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

extension CustomTextView {
    
    func setBodyFont() {
        self.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = UIFont(name: "Swiss721LightCondensedBT", size: self.font.pointSize)
    }
    
}