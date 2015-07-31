import UIKit
import Cartography

class ReviewViewController: FormViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "REVIEW REPORT"
 
        registerTextFields([locationTextField,categoryTextField,descriptionTextView])

        var descFlag = false
        setupCategoryFields()
        setupLocationFields()
        setupDescriptionFields()
        setupImageFields()
        
        constrain(categoryLabel) { categoryLabel in
            categoryLabel.width == categoryLabel.superview!.width * 0.8
        }
        
        self.view.backgroundColor = UIColor.whiteColor()
        addNextButton("SUBMIT", segueIdentifier: "ThankYouSegue")
    }
    
    func setupCategoryFields(){
        categoryLabel.setHeadingFontSmall()
        categoryLabel.text! = categoryLabel.text!.uppercaseString
        categoryTextField.setBodyFont()
        if let categoryName = Report.getCurrentReport().category?.name {
            categoryTextField.text = categoryName
        }
    }
    
    func setupLocationFields(){
        locationLabel.setHeadingFontSmall()
        locationLabel.text! = locationLabel.text!.uppercaseString
        locationTextField.setBodyFont()

        descriptionTextView.setBodyFont()
        descriptionLabel.setHeadingFontSmall()
        descriptionLabel.text! = descriptionLabel.text!.uppercaseString
        descriptionLabel.layer.borderWidth = 0.0 // no border
        
        if let locationDescription = Report.getCurrentReport().location?.desc {
            locationTextField.text = locationDescription
        }
    }
    
    func setupDescriptionFields(){
        descriptionTextView.setBodyFont()
        descriptionLabel.setHeadingFontSmall()
        if let description = Report.getCurrentReport().description {
            descriptionLabel.hidden = false
            descriptionTextView.hidden = false
            descriptionTextView.text = description
        } else {
            descriptionLabel.hidden = true
            descriptionTextView.hidden = true
        }
    }
    
    func setupImageFields(){
        if let image = Report.getCurrentReport().image {
            photoView.image = UIImage(data:image);
            photoView.contentMode = UIViewContentMode.ScaleAspectFit;
            
            if descriptionTextView.hidden {
                constrain(photoView, categoryTextField) { photoView, categoryTextField in
                    photoView.top == categoryTextField.bottom+20
                }
            }else{
                
            }
        } else {
            photoView.hidden = true
        }
    }

    override func showDefaultBackground() -> Bool {
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        let isRegistered = UserTokenMgr.sharedInstance.hasToken()
        if(isRegistered) {
            Report.getCurrentReport().userUUID = UserTokenMgr.sharedInstance.token()!
        }
        var segueIdentifier = isRegistered ? "ThankYouSegue" : "SignUpSegue"
        super.performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
    
}