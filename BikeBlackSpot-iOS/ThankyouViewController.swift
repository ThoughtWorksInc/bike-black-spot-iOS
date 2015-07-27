import UIKit
import SwiftLoader

class ThankyouViewController: UIViewController {
    
    @IBOutlet var doneButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SwiftLoader.show(animated: true)
        
        self.view.enableUserInteraction(false) // why doesn't this work?
        doneButton.enabled = false
        
        // TODO should this be done in previous screen?
        
        var isRegistered = UserTokenMgr.sharedInstance.hasToken()
        let report = Report.getCurrentReport()
        if(!isRegistered) {
            if let user = report.user {
                APIService.sharedInstance.registerUser(user)
                    .then { uuid -> Void in
                        SwiftLoader.hide()
                        
                        self.view.enableUserInteraction(true)
                        self.doneButton.enabled = true
                        
                        UIAlertView(title: "Success", message: "User has been registered", delegate: nil, cancelButtonTitle: "OK").show()
                        
                        // TODO call create report here
                    }
                    .catch { error in
                        UIAlertView(title: "Error", message: "Error registering user", delegate: nil, cancelButtonTitle: "OK").show()
                    }
            }
        } else {
            SwiftLoader.hide()
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        Report.clearReport()
        return true
    }
}