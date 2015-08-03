import Foundation
import UIKit

extension UITextView {
    
    func setBodyFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize + 4)
    }
    
    func setHeadingFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize + 4)
    }
    
    func setTitleFont() {
        self.font = Font.heading(20.0)
    }
}