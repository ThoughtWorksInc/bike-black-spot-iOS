import Foundation
import UIKit

public class FormViewController : UIViewController {
    
    let placeholderTextColor = UIColor.lightGrayColor()
    let textFieldBorderColor = UIColor.lightGrayColor()
    let textColor = UIColor.blackColor()

    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func registerTextFields(fields:[AnyObject]) {
        for field in fields {
            if let view = field as? UIView {     
                view.layer.borderColor = textFieldBorderColor.CGColor
                view.layer.borderWidth = 1.0
                view.layer.cornerRadius = 5.0
            }
        }
    }
}