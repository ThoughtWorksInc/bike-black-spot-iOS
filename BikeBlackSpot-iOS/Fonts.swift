//
//  Fonts.swift
//  BikeBlackSpot-iOS
//
//  Created by John Geddes on 28/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

public func setupFonts()
{
    UILabel.appearance().font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    UILabel.appearance().setGlobalFont = "AlternateGothicLT-No2"
    
    CustomTextView.appearance().font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    CustomTextView.appearance().setGlobalFont = "Swiss721LightCondensedBT"
}