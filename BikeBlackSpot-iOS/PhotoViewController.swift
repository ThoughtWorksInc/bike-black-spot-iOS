import UIKit
import Cartography

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //var takePhotoButton:UIButton?
    var galleryPhotoButton:UIButton?
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraIcon = UIImage(named: "camera.png") as UIImage!
        var galleryIcon = UIImage()
        
        println(cameraIcon!.size.width)
        
        picker.delegate = self
        
        //takePhotoButton = UIButton()
        let takePhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton

        takePhotoButton.setTitle("Take A Photo", forState: UIControlState.Normal)
        takePhotoButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        takePhotoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -300, 0, 20) //400
        takePhotoButton.backgroundColor = UIColor.redColor()
        takePhotoButton.setImage(cameraIcon, forState: UIControlState.Normal)
        takePhotoButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 200) //200
        takePhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        takePhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        //takePhotoButton!.contentEdgeInsets = UIEdgeInsetsMake(0, 200, 0, 200)

        
        takePhotoButton.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(takePhotoButton)
        
        constrain(takePhotoButton) { takePhotoButton in
            takePhotoButton.center == takePhotoButton.superview!.center
            takePhotoButton.width == takePhotoButton.superview!.width * 0.8
            takePhotoButton.height == takePhotoButton.superview!.height * 0.3334
        }
        
        galleryPhotoButton = UIButton()
        galleryPhotoButton!.setTitle("Select A Photo From Gallery", forState: .Normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // http://makeapppie.com/2014/12/04/swift-swift-using-the-uiimagepickercontroller-for-a-camera-and-photo-library/
    func openCamera(sender:UIButton!)
    {
        println(sender.frame.size.width)
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
        Report.getCurrentReport().image = UIImageJPEGRepresentation(chosenImage, 1.0) //http://pinkstone.co.uk/how-to-save-a-uiimage-in-core-data-and-retrieve-it/
        println("Image taken~!")
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}