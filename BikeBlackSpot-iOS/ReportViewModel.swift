import Foundation

enum ReportField {
    case Category
    case Description
    case Name
    case Email
    case Postcode
}

class ReportViewModel {
    
    let EMAIL_REGEX = "^[\\w+\\-.]+@[a-z\\d\\-]+(\\.[a-z]+)*\\.[a-z]+$"
    let POSTCODE_REGEX = "^([0-9]{4})?$"
    
    var requiredFields:[ReportField]!
    var validationRules:[ReportField:String]!
    
    init() {
        requiredFields = [ReportField.Name, ReportField.Email]
        validationRules = [ReportField.Email : EMAIL_REGEX, ReportField.Postcode : POSTCODE_REGEX]
    }
    
    func isValid(field:ReportField, value:String) -> Bool {
        var valid = true
        
        if(contains(requiredFields, field)) {
            valid = !value.isEmpty
        }
        
        if let regex = validationRules[field] {
            let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
            valid = predicate.evaluateWithObject(value)
        }
    
        return valid
    }
}
