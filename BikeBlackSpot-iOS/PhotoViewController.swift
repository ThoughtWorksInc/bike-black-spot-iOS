import UIKit
import Cartography

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let IMAGE_MAX_WIDTH:CGFloat = 1000.0
    let IMAGE_MAX_HEIGHT:CGFloat = 1000.0

    @IBOutlet weak var segueButton: UIBarButtonItem!

    let picker = UIImagePickerController()
    let buttonAspectRatio = 0.2719486081
    
    let takePhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    let galleryPhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    var buttonSeparatorLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSeparatorLabel = UILabel()
        
        picker.delegate = self
        
        buttonSeparatorLabel?.setBodyFont()
        buttonSeparatorLabel!.text = "OR"
        
        Background.setBackground(self)
        
        takePhotoButton.setTitle("Take a photo".uppercaseString, forState: UIControlState.Normal)
        takePhotoButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        takePhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        takePhotoButton.titleLabel?.setHeadingFont()
        takePhotoButton.setBackgroundImage(UIImage(named: "camera_button.png"), forState: UIControlState.Normal)
        takePhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        takePhotoButton.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        galleryPhotoButton.setTitle("Upload photo".uppercaseString, forState: .Normal)
        galleryPhotoButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        galleryPhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        galleryPhotoButton.titleLabel?.setHeadingFont()
        galleryPhotoButton.setBackgroundImage(UIImage(named: "album_button.png"), forState: UIControlState.Normal)
        galleryPhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        galleryPhotoButton.addTarget(self, action: "openPhotoGallery:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(buttonSeparatorLabel!)
        self.view.addSubview(takePhotoButton)
        self.view.addSubview(galleryPhotoButton)
        
        constrain(takePhotoButton) { takePhotoButton in
            takePhotoButton.centerX == takePhotoButton.superview!.centerX
            takePhotoButton.centerY == takePhotoButton.superview!.centerY - 50
            takePhotoButton.width == takePhotoButton.superview!.width * 0.8
            takePhotoButton.height == takePhotoButton.width * self.buttonAspectRatio
        }
        
        constrain(buttonSeparatorLabel!) { buttonSeparatorLabel in
            buttonSeparatorLabel.center == buttonSeparatorLabel.superview!.center
        }
        
        constrain(galleryPhotoButton) { galleryPhotoButton in
            galleryPhotoButton.centerX == galleryPhotoButton.superview!.centerX
            galleryPhotoButton.centerY == galleryPhotoButton.superview!.centerY + 50
            galleryPhotoButton.width == galleryPhotoButton.superview!.width * 0.8
            galleryPhotoButton.height == galleryPhotoButton.width * self.buttonAspectRatio
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
        
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
    
    func openPhotoGallery(sender:UIButton!)
    {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        var resizedImage = chosenImage.resizeIfRequired(IMAGE_MAX_WIDTH, maxHeight: IMAGE_MAX_HEIGHT)
        
        Report.getCurrentReport().image = UIImageJPEGRepresentation(resizedImage, 1.0) //http://pinkstone.co.uk/how-to-save-a-uiimage-in-core-data-and-retrieve-it/
        segueButton.title = "Continue"
        println("Image taken~!")
        self.performSegueWithIdentifier("ReportReviewSegue", sender: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        takePhotoButton.titleLabel!.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    
}