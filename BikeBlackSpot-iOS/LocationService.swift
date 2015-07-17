import Foundation
import CoreLocation

public class LocationService : NSObject, CLLocationManagerDelegate {
    
    public static var sharedInstance = LocationService()
    var locationMgr:CLLocationManager
    var currentLocation:CLLocation?
    
    public override init () {
        locationMgr = CLLocationManager()
        super.init()
        locationMgr.delegate = self
    }
    
    public func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.last as? CLLocation {
            locationUpdated(location)
            locationMgr.stopUpdatingLocation()
        }
    }
    
    public func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.AuthorizedWhenInUse:
            locationMgr.startUpdatingLocation()
        default:
            locationUpdated(nil)
        }
    }
    
    func locationUpdated(location:CLLocation?) {
        currentLocation = location
        NSNotificationCenter.defaultCenter().postNotificationName(CurrentLocationUpdated, object: nil)
    }
    
    public func requestAuthorization() {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            locationMgr.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationMgr.startUpdatingLocation()
        } else {
            // TODO if user declined
        }
    }
    
    public func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
}