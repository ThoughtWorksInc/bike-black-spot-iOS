import UIKit
import PromiseKit

let DESC_TEXTVIEW_PLACEHOLDER = "Enter report description"

class DetailsViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var categoryTextField: UITextField!
    
    let placeholderTextColor = UIColor.lightGrayColor()
    let textFieldBorderColor = UIColor.lightGrayColor()
    let textColor = UIColor.blackColor()
    
    var alert:UIAlertController?
    var pickerView:UIPickerView?
    var categories:[ReportCategory] = [ReportCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descTextView.delegate = self
        descTextView.textColor = textColor
        
        categoryTextField.attributedPlaceholder = NSAttributedString(string: "Select report category", attributes: [NSForegroundColorAttributeName: placeholderTextColor])
        categoryTextField.delegate = self
        
        for view in [descTextView, categoryTextField] {
            view.layer.borderColor = textFieldBorderColor.CGColor
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 5.0
        }
        
        var alert = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(cancel)
        
        var picker = UIPickerView()
        picker.frame = CGRect(origin: CGPointZero, size: CGSizeMake(CGRectGetWidth(alert.view.frame), 300))
        picker.delegate = self
        alert.view.addSubview(picker)
        
        self.pickerView = picker
        self.alert = alert
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        // set description
        Report.getCurrentReport().description = !descTextView.text.isEmpty && descTextView.text != DESC_TEXTVIEW_PLACEHOLDER ? descTextView.text : nil
        
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // set selected values if any
        descTextView.text = Report.getCurrentReport().description
        categoryTextField.text = Report.getCurrentReport().category?.name
        
        showDefaultState(descTextView, show: descTextView.text.isEmpty)
        
        // fetch categories
        APIService.sharedInstance.getCategories().then { object -> Void in
            self.categories = object
            self.pickerView?.reloadAllComponents()
            }
            .catch { error in
                
                // TODO if error
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        presentViewController(alert!, animated: true, completion: nil)
        return false
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if(textView.text == DESC_TEXTVIEW_PLACEHOLDER) {
            textView.text = nil
            showDefaultState(textView, show: false)
        }
        return true
    }
    
    func showDefaultState(textView:UITextView, show:Bool) {
        textView.textColor = show ? placeholderTextColor : textColor
        if(show) {
            textView.text = DESC_TEXTVIEW_PLACEHOLDER
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var selected = categories[row]
        Report.getCurrentReport().category = selected
        categoryTextField.text = selected.name
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        // content validation
        if(Report.getCurrentReport().category == nil || Report.getCurrentReport().description == nil) {
            let alert = UIAlertView(title: "Error", message: "Please enter required information", delegate: nil, cancelButtonTitle: "OK")
            alert.promise().then { object -> Void in
                
            }
            return false
        }
        return true
    }
}
