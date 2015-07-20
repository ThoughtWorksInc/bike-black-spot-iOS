import UIKit
import GoogleMaps
import Cartography

let LOCATION_PLACEHOLDER = "Please select your location"
let DEFAULT_COORDINATES = CLLocationCoordinate2D(latitude: -27.921,longitude:133.247)

class LocationViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView:GMSMapView?
    var labelView:UILabel?
    var viewModel:LocationViewModel
    
    required init(coder aDecoder:NSCoder) {
        self.viewModel = LocationViewModel()
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: nil)
        mapView.myLocationEnabled = true
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        var markerView = UIImageView(image: UIImage(named: "map-marker"))
        self.view.addSubview(markerView)
        
        labelView = UILabel()
        labelView!.text = LOCATION_PLACEHOLDER
        labelView!.backgroundColor = UIColor.clearColor()
        labelView!.textColor = UIColor.whiteColor()
        labelView!.font = UIFont.systemFontOfSize(13.0)
        labelView!.textAlignment = NSTextAlignment.Center
        labelView!.numberOfLines = 0
        
        var detailsView = UIView()
        detailsView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        detailsView.addSubview(labelView!)
        self.view.addSubview(detailsView)
        
        constrain(labelView!) { labelView in
            labelView.left == labelView.superview!.left+10
            labelView.right == labelView.superview!.right-10
            labelView.centerY == labelView.superview!.centerY
        }
        
        constrain(mapView, markerView, detailsView) { mapView, markerView, detailsView in
            mapView.edges == mapView.superview!.edges
            markerView.bottom == markerView.superview!.centerY
            markerView.centerX == markerView.superview!.centerX
            
            detailsView.height == 40
            detailsView.top == detailsView.superview!.top
            detailsView.left == detailsView.superview!.left
            detailsView.right == detailsView.superview!.right
        }
        
        self.mapView = mapView
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdated:", name: CurrentLocationUpdated, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func locationUpdated(sender:NSNotification) {
        if let currentLocation = LocationService.sharedInstance.getCurrentLocation() {
            println("lat \(currentLocation.coordinate.latitude) - long \(currentLocation.coordinate.longitude)")
            mapView!.camera = GMSCameraPosition.cameraWithTarget(currentLocation.coordinate, zoom: 15)
        }
        else {
            mapView!.camera = GMSCameraPosition.cameraWithTarget(DEFAULT_COORDINATES, zoom: Constants.DEFAULT_ZOOM_LEVEL)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        LocationService.sharedInstance.requestAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        var coordinate = mapView.camera.target
        println("lat \(coordinate.latitude) - long \(coordinate.longitude)")
        setCurrentLocation( CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    func setCurrentLocation( location: CLLocation){

        LocationService.sharedInstance.addressFromGeocode(location, handler: {(placemark) -> Void in
            if let currentPlacemark = placemark {
                
                self.viewModel.mapZoomLevel = self.mapView?.camera.zoom
                self.viewModel.placemark = currentPlacemark
                
                Report.getCurrentReport().setLocation(location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                self.labelView!.text = self.viewModel.getDescription()
            }
        })
    }
}

