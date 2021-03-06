import UIKit
import FontAwesome_swift

let VALIDATION_ERROR = "Please provide valid details"

class UserDetailsViewController: FormViewController, UITextFieldDelegate {
    
    @IBOutlet var UserPromptLabel: UILabel!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var postcodeField: UITextField!
    
    var reportViewModel:ReportViewModel!
    
    var icons = [FontAwesome.User, FontAwesome.Envelope, FontAwesome.LocationArrow]
    var placeholders = ["Name", "Email", "Postcode (optional)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "USER DETAILS"
        
        nameField.delegate = self
        emailField.delegate = self
        postcodeField.delegate = self
        
        UserPromptLabel.setBodyFont()
        UserPromptLabel.textColor = UIColor.whiteColor()
        nameField.setBodyFont()
        emailField.setBodyFont()
        postcodeField.setBodyFont()
        
        reportViewModel = ReportViewModel()
        
        var fields = [nameField, emailField, postcodeField]
        
        registerTextFields(fields, icons: icons, placeholders: placeholders)
        
        if let savedUser = Report.getCurrentReport().user {
            autoFillTextFields(savedUser)
        }
        
        emailField.keyboardType = UIKeyboardType.EmailAddress
        postcodeField.keyboardType = UIKeyboardType.NumberPad
        
        addNextButton("REGISTER", segueIdentifier: "ThankYouSegue")

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
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
        else {
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
    
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        if(!revalidateFields()) {
            showErrorAlert(VALIDATION_ERROR)
            return
        }
        setUser()
        super.performSegueWithIdentifier(identifier, sender: sender)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        UserPromptLabel.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        UserPromptLabel.setBodyFont()
        nameField.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        nameField.setBodyFont()
        emailField.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        emailField.setBodyFont()
        postcodeField.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        postcodeField.setBodyFont()
        
        var fields = [nameField, emailField, postcodeField]
        registerTextFields(fields, icons: icons, placeholders: placeholders)
        
        emailField.keyboardType = UIKeyboardType.EmailAddress
        postcodeField.keyboardType = UIKeyboardType.NumberPad
    }
}
