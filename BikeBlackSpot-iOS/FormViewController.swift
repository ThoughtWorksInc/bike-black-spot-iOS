import Foundation
import UIKit

public class FormViewController : UIViewController {
    
    let placeholderTextColor = UIColor.lightGrayColor()
    let textFieldBorderColor = UIColor.lightGrayColor()
    let textColor = UIColor.blackColor()
    var textFields:[AnyObject]?
    
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
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
    
    func allFieldsValid() -> Bool {
        if let fields = textFields {
            for field in fields {
                if !isFieldValid(field) {
                    return false
                }
            }
        }
        return true
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
    
    func showEmptyFieldsAlert() {
         UIAlertView(title: "Error", message: "Please enter required information", delegate: nil, cancelButtonTitle: "OK").show()
    }
}