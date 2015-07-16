import UIKit
import GoogleMaps

class LoctionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var target: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.6, longitude: 17.2)
        var camera: GMSCameraPosition = GMSCameraPosition(target: target, zoom: 6, bearing: 0, viewingAngle: 0)
        
        var gmaps = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        gmaps.myLocationEnabled = true
        gmaps.camera = camera
        
        self.view = gmaps
        
        //        self.view = mapView
        
        //        var camera = GMSCameraPosition.cameraWithLatitude(-33.868,
//            longitude:151.2086, zoom:6)
//        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
//        
//        var marker = GMSMarker()
//        marker.position = camera.target
//        marker.snippet = "Hello World"
//        marker.appearAnimation = kGMSMarkerAnimationPop
//        marker.map = mapView
//        
//        self.view = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

