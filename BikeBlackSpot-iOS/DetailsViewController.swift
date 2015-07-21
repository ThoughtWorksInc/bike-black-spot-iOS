import UIKit
import PromiseKit

class DetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        APIService.sharedInstance.getCategories().then { object -> Void in
            
            }
            .catch { error in
//                let alert = UIAlertView(title: "Error", message: "No internet connection", delegate: nil, cancelButtonTitle: "Ok")
//                alert.promise().then { object -> Void in
//
//                }
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
