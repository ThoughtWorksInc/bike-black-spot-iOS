import Foundation
import SwiftyJSON

public class User {
    
    public var name:String?
    public var email:String?
    public var postcode:String?
    
    func toDictionary() -> [String:AnyObject]? {
        if self.postcode == nil {
            return [
                "name":self.name == nil ? "" : self.name!,
                "email":self.email == nil ? "" : self.email!,
                "postcode": self.postcode == nil ? "" : self.postcode!]
        }
        else {
            return [
                "name":self.name == nil ? "" : self.name!,
                "email":self.email == nil ? "" : self.email!]
        }
    }
}