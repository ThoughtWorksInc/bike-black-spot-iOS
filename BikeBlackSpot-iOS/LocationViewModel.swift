import Foundation
import CoreLocation

public class LocationViewModel {
    public var placemark:CLPlacemark?
    public var mapZoomLevel:Float! = 0.0
    
    public init() {}
    public func isValid() -> Bool {
        if let currPlacemark = placemark {
            if let country = currPlacemark.country {
                return country == "Australia"
            }
        }
        return false
    }
    
    public func getDescription() -> String {
        if let placemark = self.placemark {
            if(mapZoomLevel <= Constants.DEFAULT_ZOOM_LEVEL) {
                if let country = placemark.country{
                    return country
                }
            }  else if(mapZoomLevel <= Constants.STATE_ZOOM_LEVEL) {
                if let state = placemark.administrativeArea{
                    return state
                }
            } else {
                var desc = String()
                if let no = placemark.subThoroughfare {
                    desc += no + " "
                }
                
                if let name = placemark.thoroughfare {
                    desc += name
                }
                
                if(desc.isEmpty) {
                    if let landmark = placemark.name {
                        return landmark
                    }
                }
                return desc
            }
        }
        return ""
    }
}
