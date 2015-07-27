import UIKit
import Cartography

class ReviewViewController: FormViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTextFields([locationTextField,categoryTextField,descriptionTextView])
        
        
        let report = Report.getCurrentReport()
        var descFlag = false
        
        if let locationDescription = report.location?.desc {
            locationTextField.text = locationDescription
        }
        if let categoryName = report.category?.name {
            categoryTextField.text = categoryName
        }
        if let description = report.description {
            descriptionLabel.hidden = false
            descriptionTextView.hidden = false
            descriptionTextView.text = description
            descFlag = true
        }
        else {
            descriptionLabel.hidden = true
            descriptionTextView.hidden = true
        }
        
        if let image = report.image {
            photoView.image = UIImage(data:image);
            photoView.contentMode = UIViewContentMode.ScaleAspectFit;
            
        } else {
            photoView.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNextScreen(sender: AnyObject) {
        var isRegistered = UserTokenMgr.sharedInstance.hasToken()
        var segueIdentifier = isRegistered ? "ThankYouSegue" : "UserDetailsSegue"
        self.performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
    
}