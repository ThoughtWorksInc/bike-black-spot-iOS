import UIKit
import Cartography

class ReviewViewController: FormViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTextFields([locationTextField,categoryTextField,descriptionTextView])
        
        
        let report = Report.getCurrentReport()
        
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
        }
        else {
            descriptionLabel.hidden = true
            descriptionTextView.hidden = true
        }
        constrain(locationTextField) { textView in
            textView.top == textView.superview!.top+10
            textView.left == textView.superview!.left+10
            textView.right == textView.superview!.right-10
        }
        
        constrain(categoryTextField) { textView in
            textView.left == textView.superview!.left+10
            textView.right == textView.superview!.right-10
        }
        
        constrain(descriptionTextView) { textView in
            textView.left == textView.superview!.left+10
            textView.right == textView.superview!.right-10
        }

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNextScreen(sender: AnyObject) {
        var segueIdentifier = RegistrationService.sharedInstance.isRegistered() ? "ThankYouSegue" : "UserDetailsSegue"
        self.performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
}