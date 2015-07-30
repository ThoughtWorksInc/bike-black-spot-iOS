import UIKit
import PromiseKit
import SwiftyJSON

let DESC_TEXTVIEW_PLACEHOLDER = "Enter report description"
let CATEGORY_PLACEHOLDER = "Select a category"
let SERVICE_UNAVAILABLE = "Service is currently unavailable"
let PLEASE_SELECT_A_CATEGORY = "Please enter required information"
let PICKER_HEIGHT:CGFloat = 162.0
let KEYBOARD_TOOLBAR_HEIGHT:CGFloat = 50.0


class DetailsViewController: FormViewController, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var descTextView: CustomTextView!
    @IBOutlet var categoryTextField: UITextField!
    
    var alert:UIAlertController?
    var pickerView:UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DETAILS"
        
        descTextView.textColor = textColor
        descTextView.placeholderTextColor = UIColor.grayColor()
        descTextView.placeholderText = DESC_TEXTVIEW_PLACEHOLDER
        
        if let savedDescription = Report.getCurrentReport().description {
            descTextView.text = savedDescription
        }
        
        categoryTextField.setHeadingFont()
        categoryTextField.attributedPlaceholder = NSAttributedString(string: CATEGORY_PLACEHOLDER.uppercaseString, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
//        categoryTextField.opaque = false
//        categoryTextField.backgroundColor = UIColor.clearColor()
        categoryTextField.delegate = self
        
        registerTextFields([descTextView, categoryTextField])
        
        var alert = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let select = UIAlertAction(title: "Select", style: .Cancel) { (action) in
            self.pickerView?.resignFirstResponder()
        }
        alert.addAction(select)
        
        var picker = UIPickerView()
        picker.showsSelectionIndicator = true
        picker.frame = CGRect(origin: CGPointZero, size: CGSizeMake(CGRectGetWidth(alert.view.frame), PICKER_HEIGHT))
        picker.delegate = self
        picker.dataSource = self
        if Categories.isNotLoaded() {
            Categories.setupCallback(self)
        }
        alert.view.addSubview(picker)
        
        self.pickerView = picker
        self.alert = alert
        
        addNextButton("NEXT", segueIdentifier: "PhotoSegue")
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
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
        categoryTextField.text = Report.getCurrentReport().category?.name!.uppercaseString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        setReportDescription()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if(textField == categoryTextField) {
            self.view.endEditing(true)
        }
        presentViewController(alert!, animated: true, completion: nil)
        return false
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.navigationItem.rightBarButtonItem?.title = ""
        return true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categories.categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if row == 0 {return Categories.categories[row] as? String}
        let category = Categories.categories[row] as? ReportCategory
        return category!.name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            Report.getCurrentReport().category = nil
            categoryTextField.text = nil
        }
        else {
            if let selectedCategory = Categories.categories[row] as? ReportCategory {
                Report.getCurrentReport().category = selectedCategory
                categoryTextField.text = selectedCategory.name?.uppercaseString
                categoryTextField.textColor = UIColor.blackColor()
                
                if let categoryDescription = selectedCategory.desc{
                    descTextView.setPlaceHolderText(categoryDescription + " (Tap to edit)")
                }
                resetFields()
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()

        pickerLabel.setPickerFontLarge()
        pickerLabel.textAlignment = NSTextAlignment.Center
        
        if row == 0 {
            Report.getCurrentReport().category = nil
            categoryTextField.text = nil
            descTextView.setPlaceHolderText(DESC_TEXTVIEW_PLACEHOLDER)
            pickerLabel.text = CATEGORY_PLACEHOLDER
            return pickerLabel
        }
        let currentCategory = Categories.categories[row] as? ReportCategory
        pickerLabel.text = currentCategory!.name
        
        return pickerLabel
    }
    
    func setReportDescription() {
        Report.getCurrentReport().description = descTextView.getText()
    }
    
    func reloadCategories() {
        pickerView!.reloadAllComponents()
    }
    
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        setReportDescription()
        
        if(Report.getCurrentReport().category == nil) {
            UIAlertView(title: "Error", message: PLEASE_SELECT_A_CATEGORY, delegate: nil, cancelButtonTitle: "OK").show()
            if let textField = categoryTextField {
                textField.layer.borderColor = UIColor.redColor().CGColor
            }
            return
        }
        super.performSegueWithIdentifier(identifier, sender: sender)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        descTextView!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        categoryTextField!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        categoryTextField.setHeadingFont()
    }
}
