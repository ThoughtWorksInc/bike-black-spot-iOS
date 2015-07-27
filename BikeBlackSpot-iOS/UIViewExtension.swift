//
//  UIViewExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 27/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // recursively enable/disable interaction
    func enableUserInteraction(enabled:Bool) {
        self.userInteractionEnabled = enabled
        for view in self.subviews {
            view.enableUserInteraction(enabled)
        }
    }
}
