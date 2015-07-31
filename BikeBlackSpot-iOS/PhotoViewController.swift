import UIKit
import Cartography

class PhotoViewController: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let IMAGE_MAX_WIDTH:CGFloat = 1000.0
    let IMAGE_MAX_HEIGHT:CGFloat = 1000.0
    
    let picker = UIImagePickerController()
    let buttonAspectRatio = 0.2719486081
    
    let takePhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    let galleryPhotoButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    
    let imageAttachedIconView = UIImageView()
    var buttonSeparatorLabel:UILabel = UILabel()
    var imageOptionalLabel:UILabel = UILabel()
    var imageOptionalText:UILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PHOTO"
        
        picker.delegate = self
        
        setupImageOptionalLabel()
        setupImageOptionalText()
        
        setupTakePhotoButton()
        setupButtonSeperatorLabel()
        setupGalleryPhotoButton()
        
        setupImageAttachedIcon()
        
        self.view.addSubview(imageOptionalLabel)
        self.view.addSubview(imageOptionalText)
        self.view.addSubview(buttonSeparatorLabel)
        self.view.addSubview(takePhotoButton)
        self.view.addSubview(galleryPhotoButton)
        self.view.addSubview(imageAttachedIconView)
        
        addConstraints()
        
        addNextButton("SKIP", segueIdentifier: "ReviewSegue")
        
        setupNotificationObserver()
    }
    
    func setupImageOptionalLabel(){
        imageOptionalLabel.text = "OPTIONAL:"
        imageOptionalLabel.setBodyFont()
        imageOptionalLabel.textColor = UIColor.whiteColor()
        imageOptionalLabel.setHeadingFontLarge()
    }
    
    func setupImageOptionalText(){
        imageOptionalText.text = "you can skip to the next step"
        imageOptionalText.setBodyFont()
        imageOptionalText.textColor = UIColor.whiteColor()
    }
    
    func setupButtonSeperatorLabel(){
        buttonSeparatorLabel.setBodyFont()
        buttonSeparatorLabel.text = "or"
        buttonSeparatorLabel.textColor = UIColor.whiteColor()
    }
    
    func setupTakePhotoButton(){
        takePhotoButton.setTitle("Take a photo".uppercaseString, forState: UIControlState.Normal)
        takePhotoButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        takePhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        takePhotoButton.titleLabel?.setHeadingFontLarge()
        
        takePhotoButton.setBackgroundImage(UIImage(named: "camera_button.png"), forState: UIControlState.Normal)
        takePhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        takePhotoButton.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setupGalleryPhotoButton(){
        galleryPhotoButton.setTitle("Upload a photo".uppercaseString, forState: .Normal)
        galleryPhotoButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        galleryPhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        galleryPhotoButton.titleLabel?.setHeadingFontLarge()
        galleryPhotoButton.titleLabel?.font
        
        galleryPhotoButton.setBackgroundImage(UIImage(named: "album_button.png"), forState: UIControlState.Normal)
        galleryPhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        galleryPhotoButton.addTarget(self, action: "openPhotoGallery:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    func setupImageAttachedIcon(){
        imageAttachedIconView.image = UIImage(named: ("remove-photo"))
        imageAttachedIconView.contentMode = UIViewContentMode.ScaleAspectFit
        
        imageAttachedIconView.userInteractionEnabled = true
        imageAttachedIconView.hidden = true
        
        let removeImage = UITapGestureRecognizer(target: self, action: Selector("askToRemoveImage"))
        imageAttachedIconView.addGestureRecognizer(removeImage)
    }
    
    func askToRemoveImage(){
        let alertView = UIAlertController(title: "", message: "Remove the photo", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alertView.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: {(alertView) -> Void in self.removeImage()} ))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    func removeImage(){
        Report.getCurrentReport().image = nil
        self.imageAttachedIconView.hidden = true
    }
    
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
        
        setNextButtonTitle("CONTINUE")
        imageAttachedIconView.hidden = false
        println("Image taken~!")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        takePhotoButton.titleLabel!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        takePhotoButton.titleLabel!.setHeadingFontLarge()
        galleryPhotoButton.titleLabel!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        galleryPhotoButton.titleLabel!.setHeadingFontLarge()
        imageOptionalLabel.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        imageOptionalLabel.setBodyFont()
        imageOptionalText.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        imageOptionalText.setBodyFont()
        buttonSeparatorLabel.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        buttonSeparatorLabel.setBodyFont()
    }
    
    func setupNotificationObserver(){
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
    }
    
    func addConstraints(){
        constrain(imageOptionalLabel) { optionalLabel in
            optionalLabel.centerX == optionalLabel.superview!.centerX
            optionalLabel.centerY == (optionalLabel.superview!.centerY - self.BUTTON_HEIGHT) - 140
        }
        
        constrain(imageOptionalText, imageOptionalLabel) { optionalText, optionalLabel in
            optionalText.centerX == optionalText.superview!.centerX
            optionalText.centerY == optionalLabel.bottom + Constants.BASE_PADDING
        }
        
        constrain(takePhotoButton) { takePhotoButton in
            takePhotoButton.centerX == takePhotoButton.superview!.centerX
            takePhotoButton.centerY == (takePhotoButton.superview!.centerY - self.BUTTON_HEIGHT) - 50
            takePhotoButton.width == takePhotoButton.superview!.width * 0.8
            takePhotoButton.height == takePhotoButton.width * self.buttonAspectRatio
        }
        
        constrain(buttonSeparatorLabel) { buttonSeparatorLabel in
            buttonSeparatorLabel.centerY == buttonSeparatorLabel.superview!.centerY - self.BUTTON_HEIGHT
            buttonSeparatorLabel.centerX == buttonSeparatorLabel.superview!.centerX
        }
        
        constrain(galleryPhotoButton) { galleryPhotoButton in
            galleryPhotoButton.centerX == galleryPhotoButton.superview!.centerX
            galleryPhotoButton.centerY == (galleryPhotoButton.superview!.centerY - self.BUTTON_HEIGHT) + 50
            galleryPhotoButton.width == galleryPhotoButton.superview!.width * 0.8
            galleryPhotoButton.height == galleryPhotoButton.width * self.buttonAspectRatio
        }
        
        constrain(imageAttachedIconView, galleryPhotoButton, button!) { iconView, galleryButton, baseButton in
            iconView.centerX == iconView.superview!.centerX
            iconView.centerY == (iconView.superview!.centerY - self.BUTTON_HEIGHT) + 150
            iconView.height == iconView.superview!.height * 0.2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}