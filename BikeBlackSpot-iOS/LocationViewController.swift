import UIKit
import GoogleMaps
import Cartography

class LocationViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView:GMSMapView?
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init(coder aDecoder:NSCoder) {
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
        
        constrain(mapView, markerView) { mapView, markerView in
            mapView.edges == mapView.superview!.edges
            markerView.bottom == markerView.superview!.centerY
            markerView.centerX == markerView.superview!.centerX
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        LocationService.sharedInstance.requestAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        var coordinate = mapView.camera.target
        println("lat \(coordinate.latitude) - long \(coordinate.longitude)")
    }
}

