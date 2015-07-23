import UIKit

class UserDetailsViewController: FormViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!

    let EMAIL_REGEX = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    let POSTCODE_REGEX = "^[0-9]{4}$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fields = [nameField, emailField, postcodeField]
        registerTextFields(fields)
        
        emailField.keyboardType = UIKeyboardType.EmailAddress
        postcodeField.keyboardType = UIKeyboardType.NumberPad
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
        var values = fieldValues()
        
        for (index, value) in enumerate(values) {
            switch index {
            case 0:
                user.name = value
            case 1:
                user.email = value
            case 2:
                user.postcode = value
            default:
                println("Not implemented")
            }
        }
        Report.getCurrentReport().user = user
    }
    
    override func isFieldValid(field: AnyObject) -> Bool {
        if let textField = field as? UITextField {
            var value = textField.text.trim()
            var valid = !value.isEmpty
            if(valid) {
                var regex = ""
                if(textField == emailField) {
                    regex = EMAIL_REGEX
                } else if(textField == postcodeField) {
                    regex = POSTCODE_REGEX
                }
                
                if(!regex.isEmpty) {
                    let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
                    valid = predicate.evaluateWithObject(value)
                }
            }
            return valid
        }
        return false
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        resetFields()
        
        if(!allFieldsValid()) {
            showErrorAlert("Please provide your details")
            return false
        }
        setUser()
        return true
    }
}
