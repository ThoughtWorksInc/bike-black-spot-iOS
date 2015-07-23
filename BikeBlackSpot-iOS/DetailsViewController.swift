import UIKit
import PromiseKit
import SwiftyJSON

let DESC_TEXTVIEW_PLACEHOLDER = "Enter report description"
let CATEGORY_PLACEHOLDER = "Select report category"
let SERVICE_UNAVAILABLE = "Service is currently unavailable"
let PLEASE_SELECT_A_CATEGORY = "Please enter required information"
let PICKER_HEIGHT:CGFloat = 162.0
let KEYBOARD_TOOLBAR_HEIGHT:CGFloat = 50.0


class DetailsViewController: FormViewController, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var descTextView: CustomTextView!
    @IBOutlet var categoryTextField: UITextField!
    
    var alert:UIAlertController?
    var pickerView:UIPickerView?
    var categories:[AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descTextView.textColor = textColor
        descTextView.placeholderTextColor = placeholderTextColor
        descTextView.placeholderText = DESC_TEXTVIEW_PLACEHOLDER
        
        categoryTextField.attributedPlaceholder = NSAttributedString(string: CATEGORY_PLACEHOLDER, attributes: [NSForegroundColorAttributeName: placeholderTextColor])
        categoryTextField.delegate = self

        
        registerTextFields([descTextView, categoryTextField])
        
        var alert = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let select = UIAlertAction(title: "Select", style: .Cancel) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(select)
        
        var picker = UIPickerView()
        picker.showsSelectionIndicator = true
        picker.frame = CGRect(origin: CGPointZero, size: CGSizeMake(CGRectGetWidth(alert.view.frame), PICKER_HEIGHT))
        picker.delegate = self
        
        alert.view.addSubview(picker)
        
        self.pickerView = picker
        self.alert = alert
        
        // fetch categories
        APIService.sharedInstance.getCategories().then { object -> Void in
            self.categories = object
            self.categories.insert(CATEGORY_PLACEHOLDER, atIndex: 0)
            self.pickerView?.reloadAllComponents()
            }
            .catch { error in
                let alert = UIAlertView(title: "Error", message: SERVICE_UNAVAILABLE, delegate: nil, cancelButtonTitle: "OK")
                alert.promise().then { object -> Void in
                }
                //TODO: Change to show unavailable screen on OK press
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        setReportDescription()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pickerView?.reloadAllComponents()
        
        // set selected values if any
        descTextView.setDefaultText(Report.getCurrentReport().description)
        categoryTextField.text = Report.getCurrentReport().category?.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if(textField == categoryTextField) {
            self.view.endEditing(true)
        }
        presentViewController(alert!, animated: true, completion: nil)
        return false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if row == 0 {return categories[row] as? String}
        let category = categories[row] as? ReportCategory
        return category!.name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            Report.getCurrentReport().category = nil
            categoryTextField.text=nil
        }
        else {
            if let selectedCategory = categories[row] as? ReportCategory {
                Report.getCurrentReport().category = selectedCategory
                categoryTextField.text = selectedCategory.name
            }
        }
    }
    
    func setReportDescription() {
        Report.getCurrentReport().description = descTextView.getText()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        setReportDescription()
        
        if(Report.getCurrentReport().category == nil) {
            UIAlertView(title: "Error", message: PLEASE_SELECT_A_CATEGORY, delegate: nil, cancelButtonTitle: "OK").show()
            return false
        }
        return true
    }
}
