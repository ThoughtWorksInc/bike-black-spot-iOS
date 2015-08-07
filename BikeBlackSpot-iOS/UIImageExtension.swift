import Foundation
import UIKit

extension UIImage {
    
    func resizeIfRequired(maxWidth:CGFloat, maxHeight:CGFloat) -> UIImage {
        var oldWidth = size.width
        var oldHeight = size.height
        if(oldWidth <= maxWidth && oldHeight <= maxHeight) {
            return self
        }
        var scaleFactor = (oldWidth > oldHeight) ? maxWidth / oldWidth : maxHeight / oldHeight

        var scale = UIScreen.mainScreen().scale
        var newWidth = oldWidth * scaleFactor / scale
        var newHeight = oldHeight * scaleFactor / scale
        var newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, scale)
        
        self.drawInRect(CGRect(origin:CGPointZero, size:CGSize(width:newSize.width, height:newSize.height)))
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage;
    }
    
    func cropToSquare() -> UIImage {
        
        // Create a copy of the image without the imageOrientation property so it is in its native orientation (landscape)
        let contextImage: UIImage = UIImage(CGImage: self.CGImage)!
        
        // Get the size of the contextImage
        let contextSize: CGSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        // Check to see which length is the longest and create the offset based on that length, then set the width and height of our rect
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)!
        
        return image
    }
}