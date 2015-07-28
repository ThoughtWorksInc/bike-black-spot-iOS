import Foundation
import SwiftyJSON

public class ReportCategory {
    public var name:String?
    public var desc:String?
    
    public init(name:String?, desc:String?) {
        self.name = name
        self.desc = desc
    }
    
    public init(json:JSON) {
        self.name = json["name"].string
        self.desc = json["description"].string
    }
}