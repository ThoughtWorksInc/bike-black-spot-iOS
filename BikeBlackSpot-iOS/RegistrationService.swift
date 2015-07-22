import Foundation

public class RegistrationService {
    public static var sharedInstance = RegistrationService()
    
    func isRegistered() -> Bool {
        return NSUserDefaults.standardUserDefaults().stringForKey("USER_TOKEN") != nil
    }
    
    func saveUserToken(token:String) {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "USER_TOKEN")
    }
}
