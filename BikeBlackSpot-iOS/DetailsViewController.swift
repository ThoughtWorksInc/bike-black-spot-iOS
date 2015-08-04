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
    
    var pickerView:UIPickerView?
    var toolbar:UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DETAILS"
        
        addCategoriesPicker()
        
        addDescriptionTextView()
        addCategoryTextField()
        
        addNextButton("NEXT", segueIdentifier: "PhotoSegue")
        
        registerTextFields([descTextView, categoryTextField])
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
    }
    
    func addCategoryTextField(){
        categoryTextField.attributedPlaceholder = NSAttributedString(string: CATEGORY_PLACEHOLDER, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
        categoryTextField.setHeadingFont()
        categoryTextField.rightView = createCategoryDropDownButton()
        categoryTextField.rightViewMode = UITextFieldViewMode.Always
        categoryTextField.delegate = self
        categoryTextField.inputView = pickerView!
    }
    
    func createCategoryDropDownButton() -> UIButton{
        let categoryButton = UIButton()
        let dropDownImage = UIImage(named: "down-arrow")
        categoryButton.addTarget(self, action: "openCategory", forControlEvents: .TouchUpInside)
        categoryButton.setImage(dropDownImage, forState: UIControlState.Normal)
        categoryButton.frame = CGRectMake(0, 0, 40, 40.8)
        return categoryButton
    }
    
    func addCategoriesPicker(){
        var picker = createPickerView()
        self.pickerView = picker
        
        if Categories.isNotLoaded() {
            Categories.setupCallback(self)
        }
    }
    
    func createPickerView() -> UIPickerView{
        var picker = UIPickerView()
        picker.showsSelectionIndicator = true
        picker.backgroundColor = UIColor.whiteColor()
        picker.alpha = 0.7
        picker.opaque = false
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRectMake(0.0,0.0, CGRectGetWidth(self.view.frame),  162.0)
        
        toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        space.width = self.view.frame.width - CGFloat(BUTTON_HEIGHT * 1.5)
        toolbar!.frame = CGRectMake(0.0,CGFloat(BUTTON_HEIGHT * -1), CGRectGetWidth(self.view.frame), CGFloat(BUTTON_HEIGHT ))
        toolbar!.alpha = 1.0
        toolbar!.tintColor = UIColor.whiteColor()
        toolbar!.barTintColor = Colour.Yellow
        toolbar!.translucent = false
        
        let doneButton = UIBarButtonItem(title: "DONE",style: .Plain,
            target:self,
            action:"categorySelected:")
        //doneButton.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Normal)
        
       doneButton.setTitleTextAttributes([
            NSFontAttributeName : UIFont(name: "AlternateGothicLT-No2", size: 20)!,
            NSForegroundColorAttributeName : UIColor.blackColor()],
            forState: UIControlState.Normal)
        
        toolbar!.items = [space, doneButton]
        picker.addSubview(toolbar!)
        return picker
    }
    
    func categorySelected(){
        categoryTextField.endEditing(true)
    }
    func openCategory() {
        categoryTextField.becomeFirstResponder()
    }
    
    func reloadCategories() {
        pickerView!.reloadAllComponents()
    }
    
    func addDescriptionTextView(){
        descTextView.textColor = textColor
        descTextView.placeholderTextColor = UIColor.grayColor()
        descTextView.placeholderText = DESC_TEXTVIEW_PLACEHOLDER
        
        if let savedDescription = Report.getCurrentReport().description {
            descTextView.text = savedDescription
        }
    }
    
    func setReportDescription() {
        Report.getCurrentReport().description = descTextView.getText()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if(textField == categoryTextField) {
                    toolbar?.hidden = false
            self.navigationItem.rightBarButtonItem?.title = ""
            DO_NOT_SHOW_DONE_BUTTON = true
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        DO_NOT_SHOW_DONE_BUTTON = false
        toolbar?.hidden = true
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
                categoryTextField.text = selectedCategory.name
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
    
    func preferredContentSizeChanged(notification: NSNotification) {
        descTextView!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        descTextView!.setBodyFont()
        categoryTextField!.font = Font.preferredFontForTextStyle(UIFontTextStyleBody)
        categoryTextField.setHeadingFont()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pickerView?.reloadAllComponents()
        
        // set selected values if any
        descTextView.setDefaultText(Report.getCurrentReport().description)
        categoryTextField.text = Report.getCurrentReport().category?.name!
    }
    
    override func viewWillDisappear(animated: Bool) {
        setReportDescription()
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        setReportDescription()
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
}
