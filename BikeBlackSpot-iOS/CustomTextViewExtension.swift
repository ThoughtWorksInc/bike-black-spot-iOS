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
    
    var setGlobalFont : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
}