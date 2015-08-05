import UIKit
import Cartography
import FontAwesome_swift

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
        
        var contentView = UIView()
        contentView.addSubview(imageOptionalLabel)
        contentView.addSubview(imageOptionalText)
        contentView.addSubview(buttonSeparatorLabel)
        contentView.addSubview(takePhotoButton)
        contentView.addSubview(galleryPhotoButton)
        contentView.addSubview(imageAttachedIconView)
        self.view.addSubview(contentView)
        
        addNextButton("SKIP", segueIdentifier: "ReviewSegue")
        
        if Report.getCurrentReport().image != nil {
            setNextButtonTitle("CONTINUE")
        }
        
        addConstraints()
        contentView.sizeToFit()
        constrain(contentView, button!) { view, button in
            view.height == view.superview!.height*0.8
            view.width == view.superview!.width
            view.bottom == button.top-Constants.BASE_PADDING
        }
        
        setupNotificationObserver()
    }
    
    func setupImageOptionalLabel(){
        imageOptionalLabel.text = "OPTIONAL"
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
        takePhotoButton.setTitle("    Take a photo".uppercaseString, forState: UIControlState.Normal)
        takePhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        takePhotoButton.titleLabel?.setHeadingFontLarge()
        
        takePhotoButton.setBackgroundImage(UIImage(named: "camera_button.png"), forState: UIControlState.Normal)
        takePhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        takePhotoButton.addTarget(self, action: "openCamera:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setupGalleryPhotoButton(){
        galleryPhotoButton.setTitle("    Upload a photo".uppercaseString, forState: .Normal)
        galleryPhotoButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        galleryPhotoButton.titleLabel?.setHeadingFontLarge()
        galleryPhotoButton.titleLabel?.font
        
        galleryPhotoButton.setBackgroundImage(UIImage(named: "album_button.png"), forState: UIControlState.Normal)
        galleryPhotoButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        galleryPhotoButton.addTarget(self, action: "openPhotoGallery:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setDisplayImage(image:UIImage?) {
        var currentImage = image != nil ? image : UIImage(named: "image_placeholder")
        
        UIView.transitionWithView(self.imageAttachedIconView,
            duration:0.5,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { self.imageAttachedIconView.image = currentImage },
            completion: nil)
        
        if let closeButton = imageAttachedIconView.viewWithTag(100) {
            closeButton.hidden = image == nil
        }
    }
    
    func setupImageAttachedIcon(){
        imageAttachedIconView.contentMode = UIViewContentMode.ScaleAspectFill
        imageAttachedIconView.clipsToBounds = true
        
        imageAttachedIconView.layer.cornerRadius = 5.0
        imageAttachedIconView.layer.borderWidth = 1.0
        imageAttachedIconView.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).CGColor
        
        var closeButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        closeButton.tag = 100
        closeButton.titleLabel!.font = UIFont.fontAwesomeOfSize(20)
        closeButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.Close), forState:UIControlState.Normal)
        closeButton.addTarget(self, action: "askToRemoveImage:", forControlEvents: UIControlEvents.TouchUpInside)
        imageAttachedIconView.addSubview(closeButton)
        
        constrain(closeButton) { label in
            label.top == label.superview!.top
            label.right == label.superview!.right
        }
        
        if let imageData = Report.getCurrentReport().image {
            setDisplayImage(UIImage(data: imageData))
        } else {
            setDisplayImage(nil)
        }
    }
    
    func askToRemoveImage(sender:UIButton){
        let alertView = UIAlertController(title: "", message: "Remove the photo", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alertView.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Cancel, handler: {(alertView) -> Void in self.removeImage()} ))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    func removeImage(){
        Report.getCurrentReport().image = nil
        setDisplayImage(nil)
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
        setDisplayImage(resizedImage)
        
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
        
        constrain(imageOptionalText, imageOptionalLabel, takePhotoButton) { optionalText, optionalLabel, takePhotoButton in
            optionalLabel.centerX == optionalLabel.superview!.centerX
            optionalLabel.top == optionalLabel.superview!.top
            
            optionalText.centerX == optionalText.superview!.centerX
            optionalText.top == optionalLabel.bottom + Constants.BASE_PADDING/2.0
            
            takePhotoButton.centerX == takePhotoButton.superview!.centerX

            takePhotoButton.top == optionalText.bottom + Constants.BASE_PADDING
            takePhotoButton.width == takePhotoButton.superview!.width * 0.8
            takePhotoButton.height == takePhotoButton.width * self.buttonAspectRatio
        }
        
        constrain(takePhotoButton, buttonSeparatorLabel, galleryPhotoButton) { takePhotoButton, buttonSeparatorLabel, galleryPhotoButton in
            buttonSeparatorLabel.centerX == buttonSeparatorLabel.superview!.centerX
            buttonSeparatorLabel.top == takePhotoButton.bottom
            
            galleryPhotoButton.centerX == galleryPhotoButton.superview!.centerX
            galleryPhotoButton.top == buttonSeparatorLabel.bottom
            galleryPhotoButton.width == galleryPhotoButton.superview!.width * 0.8
            galleryPhotoButton.height == galleryPhotoButton.width * self.buttonAspectRatio
        }
    
        constrain(galleryPhotoButton, imageAttachedIconView) { button, iconView in
            iconView.centerX == iconView.superview!.centerX
            iconView.top == button.bottom + Constants.BASE_PADDING
            iconView.height == iconView.superview!.height * 0.3
            iconView.width == iconView.height
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}