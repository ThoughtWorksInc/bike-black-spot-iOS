import Foundation
import SwiftyJSON

public class ReportCategory {
    public var name:String?
    public var desc:String?
    public var uuid:String?
    
    public init(json:JSON) {
        self.name = json["name"].string
        self.desc = json["description"].string
        self.uuid = json["uuid"].string
    }
}