import Foundation
import UIKit

public class FormViewController : BaseViewController {
    
    let DEFAULT_ERROR_MSG = "Please provide required information"
    
    let textFieldBackgroundColour = UIColor(white:1.0, alpha:0.3)
    let textFieldBorderColor = UIColor.clearColor()
    let textFieldErrorBorderColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)

    let textColor = UIColor.blackColor()
    var textFields:[AnyObject]?
    
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: "closeKeyboard:")
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.navigationItem.rightBarButtonItems = []
    }
    
    func closeKeyboard(sender: UIButton){
        self.view.endEditing(true)
    }
    

    func revalidateFields() -> Bool{
        resetFields()
        return allFieldsValid()
    }
    func registerTextFields(textFields:[AnyObject]) {
        for field in textFields {
            if let view = field as? UIView {
                view.layer.borderColor = textFieldBorderColor.CGColor
                view.layer.borderWidth = 1.0
                view.layer.cornerRadius = 5.0

                var frame = view.frame
                frame.size.height = 80
                view.frame = frame
                
                view.backgroundColor = textFieldBackgroundColour
            }
            if let textField = field as? UITextField {
                textField.setTitleFont()
            } else if let textView = field as? UITextView {
                textView.setTitleFont()
            }
        }
        self.textFields = textFields
    }
    
    func resetFields() {
        if let fields = textFields {
            for field in fields {
                if let textField = field as? UITextField {
                    textField.layer.borderColor = textFieldBorderColor.CGColor
                }
            }
        }
    }
    
    func allFieldsValid() -> Bool {
        
        var valid = true
        if let fields = textFields {
            for field in fields {
                
                if !isFieldValid(field) {
                    valid = false
                    if let textField = field as? UITextField {
                        textField.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
            }
        }
        return valid
    }
    
    func isFieldValid(field:AnyObject) -> Bool {
        return false
    }
    
    func fieldValues() -> [String] {
        var values = [String]()
        if let fields = textFields as? [UITextField] {
            for field in fields {
                if let value = field.text {
                    values.append(value.trim())
                } else {
                    // if nil return empty string
                    values.append("")
                }
            }
        } else {
            fatalError("Non text fields are not supported")
        }
        return values
    }
    
    
    func showErrorAlert(message:String?) {
        UIAlertView(title: "Error", message: message ?? DEFAULT_ERROR_MSG, delegate: nil, cancelButtonTitle: "OK").show()
    }
}