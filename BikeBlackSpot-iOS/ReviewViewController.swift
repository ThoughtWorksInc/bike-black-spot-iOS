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
        var segueIdentifier = RegistrationService.sharedInstance.isRegistered() ? "ThankYouSegue" : "UserDetailsSegue"
        self.performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
}