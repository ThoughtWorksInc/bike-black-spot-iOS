import Foundation
import UIKit

extension UIView {

    // recursively enable/disable interaction
    func enableUserInteraction(enabled:Bool) {
        self.userInteractionEnabled = enabled
        for view in self.subviews {
            view.enableUserInteraction(enabled)
        }
    }
}

extension UILabel {
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
}

extension UITextView {
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
}
