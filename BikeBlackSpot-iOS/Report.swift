import Foundation

public class Report {
    
    private static var currentReport:Report?

    public var location:Location?
    public var category:ReportCategory?
    public var user:User?
    public var image:NSData?

    public var uuid:String?
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
        var dict = [String:AnyObject]()
        dict["uuid"] = self.uuid!
        dict["category"] = self.category!.name
        dict["lat"] = self.location!.latitude!
        dict["long"] = self.location!.longitude!
        
        // TODO base-64 encode
        if let image = self.image {
            // dict.setValue("", forKey: "image")
        }
        return dict
    }
}