//
//  Report.swift
//  BikeBlackSpot-iOS
//
//  Created by Claire Dodd on 20/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation

public class Report {
    
    private static var currentReport:Report?

    private var latitude:Double?
    private var longitude:Double?
    public var userId:String?
    
    public var description:String?
    public var category:ReportCategory?
    
    public static func getCurrentReport() -> Report {
        if currentReport == nil {
            currentReport = Report()
        }
        return currentReport!
    }
    
    public func setLocation(latitude:Double, longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    public func isLocationSet() -> Bool {
        return latitude != 0.0 && longitude != 0.0
    }
}