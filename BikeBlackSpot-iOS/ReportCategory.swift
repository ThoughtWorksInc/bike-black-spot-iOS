import Foundation
import SwiftyJSON

public class ReportCategory {
    public var name:String?
    public var desc:String?
    
    public init(json:JSON) {
        println(json)
        self.name = json["name"].string
        self.desc = json["description"].string
        println(self.name)
        println(self.desc)
    }
    
    public init() {
        
    }
}