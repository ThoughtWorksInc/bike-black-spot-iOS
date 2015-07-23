import UIKit
import Cartography

class PhotoViewController: UIViewController {
    
    var takePhotoButton:UIButton?
    var galleryPhotoButton:UIButton?
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takePhotoButton = UIButton()
        takePhotoButton!.setTitle("Take A Photo", forState: UIControlState.Normal)
        takePhotoButton!.backgroundColor = UIColor.redColor()
        
        takePhotoButton!.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(takePhotoButton!)
        
        constrain(takePhotoButton!) { takePhotoButton in
            takePhotoButton.center == takePhotoButton.superview!.center
            takePhotoButton.width == takePhotoButton.superview!.width * 0.8
            takePhotoButton.height == 50
        }
        
        galleryPhotoButton = UIButton()
        galleryPhotoButton!.setTitle("Select A Photo From Gallery", forState: UIControlState.Normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openCamera(sender:UIButton!)
    {
        println("Button tapped")
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
}