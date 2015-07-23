import UIKit
import Cartography

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var takePhotoButton:UIButton?
    var galleryPhotoButton:UIButton?
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
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
    
    // http://makeapppie.com/2014/12/04/swift-swift-using-the-uiimagepickercontroller-for-a-camera-and-photo-library/
    func openCamera(sender:UIButton!)
    {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
            
        }
        else
        {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alertVC.addAction(okAction)
            presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        println("Image taken~!")
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}