import Foundation
import UIKit

extension UITextField {
    
    func setBodyFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize)
    }
    
    func setHeadingFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize)
    }
    
    func setTitleFont() {
        self.font = Font.heading(20.0)
    }
}