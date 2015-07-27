import Foundation
import SwiftLoader

public class Categories : NSObject {
    // fetch categories
    private static var numberOfAttempts = 0
    public static var categories:[AnyObject] = [AnyObject]()
    public static func loadCategories() {
        if self.numberOfAttempts++ <= 10 {
            APIService.sharedInstance.getCategories().then { object -> Void in
                Categories.categories = object
                Categories.categories.insert(CATEGORY_PLACEHOLDER, atIndex: 0)
                
                }
                .catch { error in
                    let alert = UIAlertView(title: "Error", message: SERVICE_UNAVAILABLE, delegate: nil, cancelButtonTitle: "OK")
                    
                    alert.promise().then { object -> Void in
                        Categories.loadCategories()
                    }
                    //TODO: Change to show unavailable screen on OK press
            }
        }
    }
    public static func resetNumberOfAttempts(){
        self.numberOfAttempts = 0
    }
    
}