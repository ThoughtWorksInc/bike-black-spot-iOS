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
import SwiftyJSON

public class APIService {
    public static var sharedInstance = APIService()
    private var serviceURL:String
    
    public init() {
        self.serviceURL = NSBundle(forClass:APIService.self).infoDictionary!["ServiceURL"] as! String
    }
    
    // TODO need to cache categories locally in case no internet connection
    
    public func getCategories() -> Promise<[ReportCategory]> {
        return Promise{ fulfill, reject in
            let request = Alamofire.request(.GET, serviceURL + "/categories", parameters: nil)
            request.responseJSON{ (request, response, data, error) in
                var statusCode = response?.statusCode
                
                if(error != nil) {
                    reject(error!)
                } else {
                    var json = JSON(data!)
                    var categories = [ReportCategory]()
                    for (index: String, subJson: JSON) in json {
                        var category = ReportCategory(json:subJson)
                        categories.append(category)
                    }
                    fulfill(categories)
                }
            }
//            request.responseString { _, _, string, _ in
//                println(string)
//            }
        }
    }
}
