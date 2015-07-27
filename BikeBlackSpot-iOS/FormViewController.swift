import Foundation
import UIKit

public class FormViewController : UIViewController {
    
    let DEFAULT_ERROR_MSG = "Please provide required information"
    
    let placeholderTextColor = UIColor.lightGrayColor()
    let textFieldBorderColor = UIColor.lightGrayColor()
    let textColor = UIColor.blackColor()
    var textFields:[AnyObject]?
    
    
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    public override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "closeKeyboard:")
    }
    func keyboardWillHide(notification: NSNotification) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: "closeKeyboard:")
    }
    func closeKeyboard(sender: UIButton){
        self.view.endEditing(true)
    }
    
    func registerTextFields(textFields:[AnyObject]) {
        for field in textFields {
            if let view = field as? UIView {
                view.layer.borderColor = textFieldBorderColor.CGColor
                view.layer.borderWidth = 1.0
                view.layer.cornerRadius = 5.0
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
        return true
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