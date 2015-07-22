//
//  StringExtension.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 22/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation

extension String {
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}