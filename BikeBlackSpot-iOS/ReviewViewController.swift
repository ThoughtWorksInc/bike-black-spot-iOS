import UIKit

class ReviewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNextScreen(sender: AnyObject) {
        let loggedIn = false
        
        var segueIdentifier = "UserDetailsSegue"
        if let uuid = NSUserDefaults.standardUserDefaults().stringForKey("USER_ID") {
            segueIdentifier = "ThankYouSegue"
        }
        self.performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
}