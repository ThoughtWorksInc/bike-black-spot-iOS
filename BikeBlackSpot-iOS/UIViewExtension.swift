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
