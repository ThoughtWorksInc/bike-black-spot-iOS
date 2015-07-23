//
//  LocationServiceTests.swift
//  BikeBlackSpot-iOS
//
//  Created by Anita Santoso on 23/07/2015.
//  Copyright (c) 2015 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreLocation
import Quick
import Nimble

class LocationServiceTests : QuickSpec {
    override func spec() {
        describe("getLocationDescription") {
            
            it("should return default coordinate with default zoom level as Australia") {
                var location = CLLocation(latitude: Constants.DEFAULT_MAP_LAT, longitude: Constants.DEFAULT_MAP_LONG)
                var locViewModel = LocationViewModel()
                var desc:String?
                LocationService.sharedInstance.addressFromGeocode(location, handler: { placemark in
                    locViewModel.placemark = placemark
                    locViewModel.mapZoomLevel = Constants.DEFAULT_ZOOM_LEVEL
                    desc = locViewModel.getDescription()
                })
                expect(desc).toEventually(equal("Australia"), timeout:TIMEOUT_INTERVAL_IN_SECS)
            }
            
            it("should return Melbourne location with state zoom level as VIC") {
                var location = CLLocation(latitude:-37.816684, longitude:144.963962)
                var locViewModel = LocationViewModel()
                var desc:String?
                LocationService.sharedInstance.addressFromGeocode(location, handler: { placemark in
                    locViewModel.placemark = placemark
                    locViewModel.mapZoomLevel = Constants.STATE_ZOOM_LEVEL
                    desc = locViewModel.getDescription()
                })
                expect(desc).toEventually(equal("VIC"), timeout:TIMEOUT_INTERVAL_IN_SECS)
            }
        }
    }
}
