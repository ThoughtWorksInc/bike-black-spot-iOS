import UIKit
import SwiftLoader
import PromiseKit
import Cartography
class ThankyouViewController: BaseViewController {
    
    @IBOutlet weak var middleMessage: UILabel!
    @IBOutlet weak var bottomMessage: UILabel!
    @IBOutlet weak var emailSentImageView: UIImageView!
    
    let THANK_YOU_HEADING = "THANK YOU FOR SUBMITTING YOUR REPORT"
    let THANK_YOU_MESSAGE = "A copy of your Bike Blackspot has been sent via email."
    
    let VERIFY_HEADING = "PLEASE VERIFY YOUR EMAIL ADDRESS"
    let VERIFY_MESSAGE = "Thank you for submitting your report, an email has been sent to your address, please verify your email."
    
    let UPLOADING_MESSAGE = "Sending report"
    
    let ERROR_REGISTERING = "Error registering user, could not be sent to server."
    let ERROR_SUBMITTING = "Error submitting report, the report could not be sent to the server."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SUCCESS"
        
        emailSentImageView.hidden = true
        
        middleMessage.setHeadingFontLarge()
        bottomMessage.setBodyFont()
        bottomMessage.sizeToFit()

        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        addNextButton("NEW REPORT")
        nextButton()!.addTarget(self, action: "nextButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        addConstraints()
        
        APIService.sharedInstance.isUserConfirmed()
            .then { result -> Void in
                if result {
                    self.middleMessage.text = self.THANK_YOU_HEADING
                    self.bottomMessage.text = self.THANK_YOU_MESSAGE
                    self.bottomMessage.sizeToFit()
                    self.emailSentImageView.hidden = false
                } else{
                    self.middleMessage.text = self.VERIFY_HEADING
                    self.bottomMessage.text = self.VERIFY_MESSAGE
                    self.bottomMessage.sizeToFit()
                    self.emailSentImageView.hidden = false
                }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let report = Report.getCurrentReport()
        
        var loadingMsg:String?
        if(report.hasImage()) {
            loadingMsg = UPLOADING_MESSAGE
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
                    let alert = UIAlertView(title: "Error", message: self.ERROR_REGISTERING, delegate: nil, cancelButtonTitle: "OK")
                }
            }
        }
        
        // now submit report
        promise
            .then {
                return APIService.sharedInstance.createReport(report)
            }
            .catch { error -> Void in
                self.setBusy(false)
                UIAlertView(title: "Error", message: self.ERROR_SUBMITTING, delegate: nil, cancelButtonTitle: "OK").show()
            }
            promise.then { () -> Void in
                self.setBusy(false)
            }
            .catch { error -> Void in
                self.setBusy(false)
                UIAlertView(title: "Error", message: self.ERROR_SUBMITTING, delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    
    func addConstraints(){
        constrain(middleMessage){ middleLabel in
            middleLabel.centerY == middleLabel.superview!.centerY - self.BUTTON_HEIGHT / 2
            middleLabel.centerX == middleLabel.superview!.centerX
            middleLabel.width == middleLabel.superview!.width * 0.8
        }
        constrain(bottomMessage, middleMessage){ bottomLabel, middleLabel in
            bottomLabel.width == bottomLabel.superview!.width * 0.8
            bottomLabel.centerX == bottomLabel.superview!.centerX
            bottomLabel.top == middleLabel.bottom + Constants.BASE_PADDING * 3
        }
        constrain(emailSentImageView, middleMessage){ emailIcon, middleLabel in
            emailIcon.centerX == emailIcon.superview!.centerX
            emailIcon.width == emailIcon.superview!.width * 0.2
            emailIcon.bottom == middleLabel.top - Constants.BASE_PADDING * 3
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func preferredContentSizeChanged(notification: NSNotification) {
        middleMessage.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        middleMessage.setHeadingFontLarge()
        bottomMessage.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        bottomMessage.setBodyFont()
        bottomMessage.sizeToFit()
    }

}