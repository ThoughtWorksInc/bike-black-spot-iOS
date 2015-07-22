import UIKit

class UserDetailsViewController: FormViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTextFields([nameField, emailField, postcodeField])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
