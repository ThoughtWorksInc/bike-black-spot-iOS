import UIKit
let VALIDATION_ERROR = "Please provide valid details"
class UserDetailsViewController: FormViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!

    var reportViewModel:ReportViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportViewModel = ReportViewModel()
        
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
            var valid = false
            
            switch (textField) {
            case nameField:
                valid = reportViewModel.isValid(ReportField.Name, value: value)
            case emailField:
                valid = reportViewModel.isValid(ReportField.Email, value: value)
            case postcodeField:
                valid = reportViewModel.isValid(ReportField.Postcode, value: value)
            default:
                println("Validation not applied")
            }
            return valid
        }
        return false
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        resetFields()
        
        if(!allFieldsValid()) {
            showErrorAlert(VALIDATION_ERROR)
            return false
        }
        setUser()
        return true
    }
}
