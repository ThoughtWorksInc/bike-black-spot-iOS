import UIKit
import GoogleMaps
import Cartography

let LOCATION_PLACEHOLDER = "Please select your location"
let LOCATION_ERROR_PLACEHOLDER = LOCATION_PLACEHOLDER + " within Australia"
let DEFAULT_COORDINATES = CLLocationCoordinate2D(latitude: Constants.DEFAULT_MAP_LAT,longitude:Constants.DEFAULT_MAP_LONG)

class LocationViewController: BaseViewController, GMSMapViewDelegate {
    
    var mapView:GMSMapView?
    var addressLabel:UILabel?
    var viewModel:LocationViewModel
    var locationLoaded:Bool =  false
    var addressBoxView:UIView?
    
    //    @IBOutlet weak var reportButton: UIBarButtonItem!
    
    required init(coder aDecoder:NSCoder) {
        self.viewModel = LocationViewModel()
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOCATION"
        
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: nil)
        mapView.myLocationEnabled = true
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsetsMake(64, 0, 64, 0);

        self.view.addSubview(mapView)
        
        var markerView = UIImageView(image: UIImage(named: "pin"))
        self.view.addSubview(markerView)
        
        addressLabel = UILabel()
        addressLabel!.text = LOCATION_PLACEHOLDER
        addressLabel!.setBodyFont()
        addressLabel!.backgroundColor = UIColor.clearColor()
        addressLabel!.textColor = UIColor.whiteColor()
        //addressLabel!.font = UIFont.systemFontOfSize(13.0)
        addressLabel!.textAlignment = NSTextAlignment.Center
        addressLabel!.numberOfLines = 0
        addressLabel!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        
        addressBoxView = UIView()
        addressBoxView!.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        addressBoxView!.addSubview(addressLabel!)
        self.view.addSubview(addressBoxView!)
        
        constrain(addressLabel!) { labelView in
            labelView.left == labelView.superview!.left+10
            labelView.right == labelView.superview!.right-10
            labelView.centerY == labelView.superview!.centerY
        }
        
        constrain(mapView, markerView, addressBoxView!) { mapView, markerView, detailsView in
            mapView.edges == mapView.superview!.edges
            
            markerView.bottom == markerView.superview!.centerY
            markerView.centerX == markerView.superview!.centerX
            
            detailsView.height == 40
            detailsView.top == detailsView.superview!.top
            detailsView.left == detailsView.superview!.left
            detailsView.right == detailsView.superview!.right
        }
        
        self.mapView = mapView
        
        addNextButton("REPORT", segueIdentifier:"DetailsSegue")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationUpdated:", name: CurrentLocationUpdated, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func locationUpdated(sender:NSNotification) {
        let savedLocation = Report.getCurrentReport().location
        
        if !self.locationLoaded && savedLocation != nil  {
            mapView!.camera = GMSCameraPosition.cameraWithTarget(CLLocationCoordinate2D(latitude: savedLocation!.latitude!, longitude: savedLocation!.longitude!), zoom: 15)
        }
        else {
            if let currentLocation = LocationService.sharedInstance.getCurrentLocation() {
                mapView!.camera = GMSCameraPosition.cameraWithTarget(currentLocation.coordinate, zoom: 15)
            }
            else {
                mapView!.camera = GMSCameraPosition.cameraWithTarget(DEFAULT_COORDINATES, zoom: Constants.DEFAULT_ZOOM_LEVEL)
            }
        }
        self.locationLoaded=true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        LocationService.sharedInstance.requestAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // same as below but disable on move
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        nextButton()!.enabled = false
    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        var coordinate = mapView.camera.target
        setCurrentLocation( CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    func setCurrentLocation( location: CLLocation){
        LocationService.sharedInstance.addressFromGeocode(location, handler: {(placemark) -> Void in
            if let currentPlacemark = placemark {
                self.viewModel.mapZoomLevel = self.mapView?.camera.zoom
                self.viewModel.placemark = currentPlacemark
                
                if self.viewModel.isValid() {
                    Report.getCurrentReport().location = Location(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude, description: self.viewModel.getDescription())
                    
                    self.nextButton()!.enabled = true
                    self.addressLabel!.text = self.viewModel.getDescription()
                }
                else {
                    Report.getCurrentReport().location = nil
                    self.addressLabel!.text = LOCATION_ERROR_PLACEHOLDER
                }
            }
        })
    }
    
    //zoom out slower
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        // content validation, should never actually run
        if(Report.getCurrentReport().location == nil) {
            let alert = UIAlertView(title: "Error", message: LOCATION_ERROR_PLACEHOLDER, delegate: nil, cancelButtonTitle: "OK")
            alert.promise().then { object -> Void in}
            return
        }
        
        // not zoomed too far out
        if self.mapView!.camera.zoom <= Constants.STATE_ZOOM_LEVEL {
            self.mapView!.animateToZoom(Constants.STATE_ZOOM_LEVEL+1)
            return
        }
        self.locationLoaded = false
        super.performSegueWithIdentifier(identifier, sender: sender)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        addressLabel!.setBodyFont()
        addressLabel!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
    }
}

