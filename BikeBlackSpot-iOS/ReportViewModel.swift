//
//  FormViewModel.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 24/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation

enum ReportField {
    case Category
    case Description
    case Name
    case Email
    case Postcode
}

class ReportViewModel {
    
    //Changed regex to match server side one
//    let EMAIL_REGEX = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
//    let EMAIL_REGEX = "^(.+)@((?:[-a-z0-9]+.)+[a-z]{2,})$"
    let EMAIL_REGEX = "^[\\w+\\-.]+@[a-z\\d\\-]+(\\.[a-z]+)*\\.[a-z]+$"
    let POSTCODE_REGEX = "^([0-9]{4})?$"
    
    var requiredFields:[ReportField]!
    var validationRules:[ReportField:String]!
    
    init() {
        requiredFields = [ReportField.Name, ReportField.Email]
        validationRules = [ReportField.Email : EMAIL_REGEX, ReportField.Postcode : POSTCODE_REGEX]
    }
    
    func isValid(field:ReportField, value:String) -> Bool {
        var valid = true
        
        // if required field, check not empty
        if(contains(requiredFields, field)) {
            valid = !value.isEmpty
        }
        
        if let regex = validationRules[field] {
            let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
            valid = predicate.evaluateWithObject(value)
        }
    
        return valid
    }
}
