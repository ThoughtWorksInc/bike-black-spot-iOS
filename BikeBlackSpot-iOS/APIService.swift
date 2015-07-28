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
        }
    }
    
    public func registerUser(user:User) -> Promise<String> {
        return Promise{ fulfill, reject in
            var params = user.toDictionary()
            let request = Alamofire.request(.POST, serviceURL + "/users", parameters: params)
            request.responseString { _, response, string, error in
                if(error != nil) {
                    reject(error!)
                } else if(string == nil) {
                    // if no uuid was returned
                    let statusCode = response?.statusCode
                    reject(NSError(domain: self.serviceURL, code: statusCode!, userInfo: nil))
                } else {
                    var uuid = string!.stringByReplacingOccurrencesOfString("\"", withString: "")
                    UserTokenMgr.sharedInstance.saveToken(uuid)
                    fulfill(uuid)
                }
            }
        }
    }
    
    public func isUserConfirmed() -> Promise<Bool> {
        return Promise{ fulfill, reject in
            if let uuid = UserTokenMgr.sharedInstance.token(){
                let request = Alamofire.request(.GET, serviceURL + "/users?uuid=" + uuid)
                request.responseString { _, response, string, error in
                    if(error != nil) {
                        reject(error!)
                    } else if(string == nil) {
                        let statusCode = response?.statusCode
                        reject(NSError(domain: self.serviceURL, code: statusCode!, userInfo: nil))
                    } else {
                        println(string!)
                        fulfill(string!.rangeOfString("true") != nil)
                    }
                }
            }
            else{
                fulfill(false)
            }
        }
    }
    
    public func createReport(report:Report) -> Promise<Bool> {
        return Promise{ fulfill, reject in
            var params = report.toDictionary()
            let request = Alamofire.request(.POST, serviceURL + "/reports", parameters: params)
            request.responseJSON{ (request, response, data, error) in
                var statusCode = response?.statusCode
                if(error != nil) {
                    reject(error!)
                } else {
                    fulfill(true)
                }
            }
        }
    }
}
