//
//  Location.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 22/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation

public class Location {
    
    public var latitude:Double?
    public var longitude:Double?
    
    public init(latitude:Double, longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}