import Foundation
import SwiftLoader

public class Categories : NSObject {
    private static var isLoaded = false
    private static var numberOfAttempts = 0
    private static var callBackViewController:DetailsViewController?
    public static var categories:[AnyObject] = [AnyObject]()
    
    
    public static func loadCategories() {
        if self.numberOfAttempts++ < 3 {
            APIService.sharedInstance.getCategories().then { object -> Void in
                Categories.categories = object
                Categories.categories.insert(CATEGORY_PLACEHOLDER, atIndex: 0)
                self.isLoaded = true
                if let callBackController = self.callBackViewController{
                    callBackController.reloadCategories()
                }}
                .catch { error in
                    let alert = UIAlertView(title: "Error", message: SERVICE_UNAVAILABLE, delegate: nil, cancelButtonTitle: "OK")
                    
                    alert.promise().then { object -> Void in
                        self.isLoaded = false
                        Categories.loadCategories()
                    }
                    //TODO: Change to show unavailable screen on OK press
            }
        }
    }
    public static func resetNumberOfAttempts(){
        self.numberOfAttempts = 0
    }
    
    public static func isNotLoaded() -> Bool{
        return !isLoaded
    }
    
    static func setupCallback(viewController: DetailsViewController) {
        callBackViewController = viewController
    }
    
}