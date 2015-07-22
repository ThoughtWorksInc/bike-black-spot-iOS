import Foundation
import UIKit

class CustomTextView : UITextView, UITextViewDelegate {
    
    var placeholderTextColor:UIColor?
    var placeholderText:String = ""
    var defaultTextColor:UIColor?

    required init(coder:NSCoder) {
        super.init(coder:coder)
        self.delegate = self
    }
    
    func updateTextColor() {
        if(self.defaultTextColor == nil) {
            self.defaultTextColor = self.textColor
        }
        var empty = self.text == placeholderText
        self.textColor = empty ? placeholderTextColor : self.defaultTextColor
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if(self.text.isEmpty) {
            self.text = placeholderText
        }
        updateTextColor()
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if(self.text == placeholderText) {
            self.text = nil
        }
        updateTextColor()
        return true
    }
    
    func setDefaultText(text:String?) {
        if text != nil && !text!.isEmpty {
            self.text = text
        } else {
            self.text = placeholderText
        }
        updateTextColor()
    }
    
    func getText() -> String? {
        if(self.text == placeholderText) {
            return nil
        }
        return self.text
    }
}
