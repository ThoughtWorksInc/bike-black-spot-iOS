import UIKit
import Cartography

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //var takePhotoButton:UIButton?
    //var galleryPhotoButton:UIButton?
    let picker = UIImagePickerController()
    let buttonAspectRatio = 0.2719486081
    
    let takePhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    let galleryPhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    var buttonSeparatorLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSeparatorLabel = UILabel()
        
        //let cameraIcon = UIImage(named: "camera_button.png") as UIImage!
        //var galleryIcon = UIImage()
        
        //println(cameraIcon!.size.width)
        
        picker.delegate = self
        
        buttonSeparatorLabel!.text = "OR"
        
        takePhotoButton.setTitle("take a photo".uppercaseString, forState: UIControlState.Normal)
        takePhotoButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        takePhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        takePhotoButton.titleLabel!.font = UIFont(name: "AlternateGothicLT-No2", size: 16)
        //takePhotoButton.titleEdgeInsets = UIEdgeInsetsMake(0, -300, 0, 20) //400
        //takePhotoButton.backgroundColor = UIColor.redColor()
        //takePhotoButton.setImage(cameraIcon, forState: UIControlState.Normal)
        takePhotoButton.setBackgroundImage(UIImage(named: "camera_button.png"), forState: UIControlState.Normal)
        //takePhotoButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 200) //200
        takePhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        //takePhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        takePhotoButton.layer.borderWidth = 2
        takePhotoButton.layer.borderColor = UIColor.orangeColor().CGColor
        takePhotoButton.layer.cornerRadius = 5
        //takePhotoButton!.contentEdgeInsets = UIEdgeInsetsMake(0, 200, 0, 200)
        
        takePhotoButton.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        galleryPhotoButton.setTitle("Select A Photo From Gallery", forState: .Normal)
        galleryPhotoButton.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(buttonSeparatorLabel!)
        self.view.addSubview(takePhotoButton)
        self.view.addSubview(galleryPhotoButton)
        
        constrain(takePhotoButton) { takePhotoButton in
            takePhotoButton.centerX == takePhotoButton.superview!.centerX
            takePhotoButton.centerY == takePhotoButton.superview!.centerY - 75
            takePhotoButton.width == takePhotoButton.superview!.width * 0.8
            takePhotoButton.height == takePhotoButton.width * self.buttonAspectRatio
        }
        
        constrain(buttonSeparatorLabel!) { buttonSeparatorLabel in
            buttonSeparatorLabel.center == buttonSeparatorLabel.superview!.center
            buttonSeparatorLabel.width == buttonSeparatorLabel.superview!.width * 0.8
            buttonSeparatorLabel.height == 20
        }
        
        constrain(galleryPhotoButton) { galleryPhotoButton in
            //galleryPhotoButton.center == galleryPhotoButton.superview!.center
            galleryPhotoButton.centerX == galleryPhotoButton.superview!.centerX
            galleryPhotoButton.centerY == galleryPhotoButton.superview!.centerY + 75
            galleryPhotoButton.width == galleryPhotoButton.superview!.width * 0.8
            galleryPhotoButton.height == galleryPhotoButton.superview!.height * 0.3334
        }
        
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