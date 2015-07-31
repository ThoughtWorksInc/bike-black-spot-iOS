import UIKit
import FontAwesome_swift

let VALIDATION_ERROR = "Please provide valid details"

class UserDetailsViewController: FormViewController, UITextFieldDelegate {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!
    
    var reportViewModel:ReportViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "USER DETAILS"
        
        label.setBodyFont()
        label.textColor = UIColor.whiteColor()
        
        nameField.delegate = self
        emailField.delegate = self
        postcodeField.delegate = self
        
        reportViewModel = ReportViewModel()
        
        var fields = [nameField, emailField, postcodeField]
        var icons = [FontAwesome.User, FontAwesome.Envelope, FontAwesome.MapMarker]
        var placeholders = ["Name", "Email", "Postcode (optional)"]
        registerTextFields(fields, icons: icons, placeholders: placeholders)
        
        if let savedUser = Report.getCurrentReport().user {
            autoFillTextFields(savedUser)
        }
        
        emailField.keyboardType = UIKeyboardType.EmailAddress
        postcodeField.keyboardType = UIKeyboardType.NumberPad
        
        addNextButton("SUBMIT", segueIdentifier: "ThankYouSegue")
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
    
    func textFieldDidEndEditing(textField:UITextField) {
        if isFieldValid(textField){
            textField.layer.borderColor = textFieldBorderColor.CGColor
        }
        else{
            textField.layer.borderColor = textFieldErrorBorderColor.CGColor
        }
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
    
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        if(!revalidateFields()) {
            showErrorAlert(VALIDATION_ERROR)
            return
        }
        setUser()
        super.performSegueWithIdentifier(identifier, sender: sender)
    }
}
