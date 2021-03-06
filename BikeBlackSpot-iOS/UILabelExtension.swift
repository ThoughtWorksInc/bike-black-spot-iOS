import Foundation
import UIKit

extension UILabel {
    
    func setBodyFont() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize + 2)
    }
    
    func setPickerFontLarge() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.body(self.font.pointSize + 7)
    }
    
    func setHeadingFontSmall() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = Font.heading(self.font.pointSize + 4)
    }
    
    func setHeadingFontLarge() {
        self.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        self.font = UIFont(name: "AlternateGothicLT-No2", size: self.font.pointSize + 10)
    }
}