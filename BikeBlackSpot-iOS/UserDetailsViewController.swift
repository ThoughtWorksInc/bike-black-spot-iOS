import UIKit
let VALIDATION_ERROR = "Please provide valid details"
class UserDetailsViewController: FormViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!
    
    var reportViewModel:ReportViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.setBackground(self)
        
        reportViewModel = ReportViewModel()
        
        var fields = [nameField, emailField, postcodeField]
        registerTextFields(fields)
        if let savedUser = Report.getCurrentReport().user {
            autoFillTextFields(savedUser)
        }
        
        emailField.keyboardType = UIKeyboardType.EmailAddress
        postcodeField.keyboardType = UIKeyboardType.NumberPad
    }
    
    func autoFillTextFields(savedUser:User){
        if let savedName = savedUser.name {
            nameField.text = savedName
        }
        if let savedEmail = savedUser.email {
            emailField.text = savedEmail
        }
        if let savedPostcode = savedUser.postcode {
            postcodeField.text = savedPostcode
        }
        allFieldsValid()
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
        revalidateFields()
        setUser()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        setUser() // back button pressed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func revalidateFields() -> Bool{
        resetFields()
        return allFieldsValid()
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
        if(!revalidateFields()) {
            showErrorAlert(VALIDATION_ERROR)
            return false
        }
        setUser()
        return true
    }
}
