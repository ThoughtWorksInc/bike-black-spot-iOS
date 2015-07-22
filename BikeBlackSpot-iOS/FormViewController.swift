import Foundation
import UIKit

public class FormViewController : UIViewController {
    
    let placeholderTextColor = UIColor.lightGrayColor()
    let textFieldBorderColor = UIColor.lightGrayColor()
    let textColor = UIColor.blackColor()

    func createKeyboardToolbar() -> UIToolbar {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(origin:CGPointZero, size:CGSizeMake(CGRectGetWidth(self.view.frame), KEYBOARD_TOOLBAR_HEIGHT)))
        doneToolbar.barStyle = UIBarStyle.Default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneButtonTapped:"))
    
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
    
        return doneToolbar
    }
    
    func doneButtonTapped(sender:UIButton) {
        self.view.endEditing(true)
    }
    
    func registerTextFields(fields:[AnyObject]) {
        var toolbar = createKeyboardToolbar()
        
        for field in fields {
            if let textField = field as? UITextField {
                textField.inputAccessoryView = toolbar
            } else if let textView = field as? UITextView {
                textView.inputAccessoryView = toolbar
            }
            if let view = field as? UIView {     
                view.layer.borderColor = textFieldBorderColor.CGColor
                view.layer.borderWidth = 1.0
                view.layer.cornerRadius = 5.0
            }
        }
    }
}