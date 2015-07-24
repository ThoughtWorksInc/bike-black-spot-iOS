import Foundation

public class Location {
    
    public var latitude:Double?
    public var longitude:Double?
    public var desc:String?
    
    public init(latitude:Double, longitude:Double, description:String) {
        self.latitude = latitude
        self.longitude = longitude
        self.desc = description
    }
}