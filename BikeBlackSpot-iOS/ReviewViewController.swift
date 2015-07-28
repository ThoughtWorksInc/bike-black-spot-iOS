import UIKit
import Cartography

class ReviewViewController: FormViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var imageLabel: UILabel! //<<<<We were here last, investigating whether this is nessesary
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.setBackground(self)
        
        registerTextFields([locationTextField,categoryTextField,descriptionTextView])
        
        
        let report = Report.getCurrentReport()
        var descFlag = false
        categoryLabel.setHeadingFont()
        categoryLabel.text! = categoryLabel.text!.uppercaseString
        categoryTextField.setBodyFont()
        locationLabel.setHeadingFont()
        locationLabel.text! = locationLabel.text!.uppercaseString
        locationTextField.setBodyFont()
        descriptionTextView.setBodyFont()
        descriptionLabel.setHeadingFont()
        
        if let locationDescription = report.location?.desc {
            locationTextField.text = locationDescription
        }
        
        if let categoryName = report.category?.name {
            categoryTextField.setBodyFont()
            categoryTextField.text = categoryName
            
        }
        
        if let description = report.description {
            descriptionLabel.hidden = false
            descriptionTextView.hidden = false
            descriptionTextView.text = description
            descFlag = true
        } else {
            descriptionLabel.hidden = true
            descriptionTextView.hidden = true
        }
        
        if let image = report.image {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNextScreen(sender: AnyObject) {
        let isRegistered = UserTokenMgr.sharedInstance.hasToken()
        if(isRegistered) {
            Report.getCurrentReport().userUUID = UserTokenMgr.sharedInstance.token()!
        }
        var segueIdentifier = isRegistered ? "ThankYouSegue" : "UserDetailsSegue"
        self.performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
    
}