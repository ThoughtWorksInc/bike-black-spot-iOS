import UIKit
import SwiftLoader

class ThankyouViewController: UIViewController {
    
    @IBOutlet weak var middleMessage: UILabel!
    
    @IBOutlet weak var bottomMessage: UILabel!
    
    @IBOutlet var doneButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Background.setBackground(self)
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        APIService.sharedInstance.isUserConfirmed()
            .then { result -> Void in
                println(result)
                if result {
                    self.middleMessage.text = "THANK YOU FOR SUBMITTING YOUR REPORT"
                    self.bottomMessage.text = "A copy of your blackspot has been sent via email."
                }else{
                    self.middleMessage.text = "PLEASE VERIFY YOUR EMAIL ADDRESS"
                    self.bottomMessage.text = "Thank you for submitting your report, an email has been sent to your address, please verify your email."
                }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setBusy(true)
        // TODO should this be done in previous screen?
        
        var isRegistered = UserTokenMgr.sharedInstance.hasToken()
        let report = Report.getCurrentReport()
        if(!isRegistered) {
            
            if let user = report.user {
                APIService.sharedInstance.registerUser(user)
                    .then { uuid -> Void in
                        self.setBusy(false)
                        UIAlertView(title: "Success", message: "User has been registered", delegate: nil, cancelButtonTitle: "OK").show()
                        
                        // TODO call create report here
                    }
                    .catch { error in
                        self.setBusy(false)
                        UIAlertView(title: "Error", message: "Error registering user", delegate: nil, cancelButtonTitle: "OK").show()
                }
            }
        } else {
            setBusy(false)
            SwiftLoader.hide()
        }
    }
    
    // TODO move to FormViewController
    func setBusy(busy:Bool) {
        if(busy) {
            SwiftLoader.show(animated: true)
            self.view.enableUserInteraction(false) // why doesn't this work?
            doneButton.enabled = false
        } else {
            SwiftLoader.hide()
            self.view.enableUserInteraction(true)
            self.doneButton.enabled = true
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        Report.clearReport()
        return true
    }
}