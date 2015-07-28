//
//  User.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 22/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import SwiftyJSON

public class User {
    
//    public var uuid:String?
    public var name:String?
    public var email:String?
    public var postcode:String?
    
    func toDictionary() -> [String:AnyObject]? {
        return [
            "name":self.name == nil ? "" : self.name!,
            "email":self.email == nil ? "" : self.email!,
            "postcode": self.postcode == nil ? "" : self.postcode!]
    }
}