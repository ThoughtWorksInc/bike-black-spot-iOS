//
//  APIService.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 20/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

public class APIService {
    public static var sharedInstance = APIService()
    private var serviceURL:String
    
    public init() {
        self.serviceURL = NSBundle(forClass:APIService.self).infoDictionary!["ServiceURL"] as! String
    }
    
    public func getCategories() -> Promise<[Category]> {
        return Promise{ fulfill, reject in
            let request = Alamofire.request(.GET, serviceURL + "/categories", parameters: nil)
            request.responseJSON{ (request, response, JSON, error) in
                var statusCode = response?.statusCode
                
                if(error != nil) {
                    reject(error!)
                } else {
                    var categories = [Category(), Category()]
                    fulfill(categories)
                }
            }
            request.responseString { _, _, string, _ in
                println(string)
            }
        }
    }
}
