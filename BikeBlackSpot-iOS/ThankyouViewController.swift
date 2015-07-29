import UIKit
import SwiftLoader
import PromiseKit

class ThankyouViewController: BaseViewController {
    
    @IBOutlet weak var middleMessage: UILabel!
    @IBOutlet weak var bottomMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "THANK YOU"
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton

        addNextButton("SEND ANOTHER REPORT")
        nextButton()!.addTarget(self, action: "nextButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        APIService.sharedInstance.isUserConfirmed()
            .then { result -> Void in

//                self.nextButton()!.enabled = true
                
                if result {
                    self.middleMessage.text = "THANK YOU FOR SUBMITTING YOUR REPORT"
                    self.bottomMessage.text = "A copy of your blackspot has been sent via email."
                } else{
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
        let report = Report.getCurrentReport()
        
        var loadingMsg:String?
        if(report.hasImage()) {
            loadingMsg = "Uploading image"
        }
        setBusy(true, text:loadingMsg)
        
        var isRegistered = UserTokenMgr.sharedInstance.hasToken()

        var promise = Promise()
        
        if(!isRegistered) {
            
            // register user
            if let user = report.user {
                promise = APIService.sharedInstance.registerUser(user)
                    .then { uuid -> Void in
                        
                        // set user uuid on report
                        Report.getCurrentReport().userUUID = uuid
                    }
                    promise.catch { error in
                        self.setBusy(false)
                        let alert = UIAlertView(title: "Error", message: "Error registering user", delegate: nil, cancelButtonTitle: "OK")
                    }
            }
        }
        
        // now submit report
        promise
            .then {
                APIService.sharedInstance.createReport(report)
                return Promise<Void>()
            }
            . then { () -> Void in
                self.setBusy(false)
            }
            .catch { error -> Void in
                self.setBusy(false)
                UIAlertView(title: "Error", message: "Error submitting report", delegate: nil, cancelButtonTitle: "OK").show()
            }
    }
    
    func setBusy(busy:Bool, text:String? = nil) {
        if(busy) {
            if let message = text {
                SwiftLoader.show(title: message, animated: true)
            } else {
                SwiftLoader.show(animated: true)
            }
            self.nextButton()!.enabled = false
        } else {
            SwiftLoader.hide()
            self.nextButton()!.enabled = true
        }
    }
    
    func nextButtonTapped(sender:UIButton) {
        Report.clearReport()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.showDefaultViewController()
    }
}