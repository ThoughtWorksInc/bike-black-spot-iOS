import Foundation
import UIKit
import Cartography


public class BaseViewController : UIViewController {
    
    var segueIdentifier:String?
    var button:UIButton?
    let BUTTON_HEIGHT:Double = 40
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    func addNextButton(text:String, segueIdentifier:String? = nil) {
        var button = createNextButton()
        
        self.view.addSubview(button)
        self.button = button
        
        setNextButtonTitle(text)
        
        constrain(button) { button in
            button.height == self.BUTTON_HEIGHT
            button.bottom == button.superview!.bottom - Constants.BASE_PADDING
            button.left == button.superview!.left + Constants.BASE_PADDING
            button.right == button.superview!.right - Constants.BASE_PADDING
        }
        
        if let id = segueIdentifier {
            self.segueIdentifier = id
            button.addTarget(self, action: "performSegue", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    func createNextButton() -> UIButton{
        var button = UIButton()
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.setBackgroundColor(Colour.Yellow, forState:UIControlState.Normal)
        button.setBackgroundColor(Colour.DarkYellow, forState:UIControlState.Disabled)
        return button
    }
    
    func setNextButtonTitle(title:String) {
        if let button = self.button {
           let title = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName:Font.buttonTitle()])
            button.setAttributedTitle(title, forState: UIControlState.Normal)
        }
    }
    
    func nextButton() -> UIButton? {
        return self.button
    }
    
    func performSegue() {
        performSegueWithIdentifier(segueIdentifier!, sender: nil)
    }
}