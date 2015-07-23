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

    public var location:Location?
    public var category:ReportCategory?
    public var user:User?
    public var image:NSData?
    
    public var userToken:String?
    public var description:String?
    
    public static func getCurrentReport() -> Report {
        if currentReport == nil {
            currentReport = Report()
        }
        return currentReport!
    }
}