import UIKit

class UserDetailsViewController: FormViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTextFields([nameField, emailField, postcodeField])
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        setUser() // back button pressed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUser() {
        var user = User()
        user.name = nameField.text
        user.email = emailField.text
        user.postcode = postcodeField.text
        Report.getCurrentReport().user = user
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        // TOOD validation here
        setUser()
        return true
    }
}
