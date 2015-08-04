import Foundation
import UIKit

extension UITextField {
    
    func setBodyFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize + 4)
    }
    
    func setBodyFontSmall() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize + 2)
    }
    
    func setHeadingFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize + 6.0)
    }
    
    func setTitleFont() {
        self.font = Font.heading(20.0)
    }
}