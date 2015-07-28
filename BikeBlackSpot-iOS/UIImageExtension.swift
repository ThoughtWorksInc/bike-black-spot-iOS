//
//  UIImageExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 28/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeIfRequired(maxWidth:CGFloat, maxHeight:CGFloat) -> UIImage {
        var oldWidth = size.width
        var oldHeight = size.height;
        if(oldWidth <= maxWidth && oldHeight <= maxHeight) {
            return self
        }
        var scaleFactor = (oldWidth > oldHeight) ? maxWidth / oldWidth : maxHeight / oldHeight
        
        var newHeight = oldHeight * scaleFactor
        var newWidth = oldWidth * scaleFactor
        var newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(newSize)
        self.drawInRect(CGRect(origin:CGPointZero, size:CGSize(width:size.width, height:size.height)))
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage;
    }
}