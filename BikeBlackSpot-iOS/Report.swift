import Foundation

public class Report {
    
    private static var currentReport:Report?
    
    public var location:Location?
    public var category:ReportCategory?
    public var user:User?
    public var userUUID:String?
    
    public var image:NSData?
    
    public var description:String?
    
    
    public static func getCurrentReport() -> Report {
        if currentReport == nil {
            currentReport = Report()
        }
        return currentReport!
    }
    
    public static func clearReport() -> Void {
        currentReport = nil
    }
    
    public func toDictionary() -> [String:AnyObject] {
        var vals = [String:AnyObject]()
        
        vals["uuid"] = self.userUUID
        vals["category"] = self.category!.uuid
        vals["lat"] = self.location!.latitude!
        vals["long"] = self.location!.longitude!
        
        // optional
        if let description = self.description {
            vals["description"] = description
        }
        // optional
        if let image = self.image {
            let base64String = image.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
            vals["image"] = base64String
        }
        return vals
    }
    
    public func hasImage() -> Bool {
        return self.image != nil
    }
}