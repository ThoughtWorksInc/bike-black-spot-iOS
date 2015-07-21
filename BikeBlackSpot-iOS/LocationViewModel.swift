//
//  Address.swift
//  BikeBlackSpot-iOS
//
//  Created by Claire Dodd on 20/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationViewModel {
    public var placemark:CLPlacemark?
    public var mapZoomLevel:Float! = 0.0
    
    public init() {}
    
    public func getDescription() -> String {
        var desc = String()
        if let placemark = self.placemark {
            if(mapZoomLevel <= Constants.DEFAULT_ZOOM_LEVEL) {
                if let country = placemark.country{
                    desc = country
                }
            }  else if(mapZoomLevel <= Constants.STATE_ZOOM_LEVEL) {
                if let state = placemark.administrativeArea{
                    desc = state
                }
            } else {
                
                if let no = placemark.subThoroughfare {
                    desc += no + " "
                }
                
                if let name = placemark.thoroughfare {
                    desc += name
                }
                
                if(desc.isEmpty) {
                    if let landmark = placemark.name {
                        desc += landmark
                    }
                }
                
                if let suburb = placemark.locality {
                    desc += ", " + suburb
                }
                
                if let postcode = placemark.postalCode {
                    desc += " " + postcode
                }
            }
        }
        return desc
    }
}
