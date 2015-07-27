import Foundation

public class UserTokenMgr {
    let USER_TOKEN = "USER_TOKEN"
    public static var sharedInstance = UserTokenMgr()
    
    func hasToken() -> Bool {
        return token() != nil
    }
    
    func saveToken(token:String?) {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: USER_TOKEN)
    }
    
    func token() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(USER_TOKEN)
    }
    
    func reset() {
        saveToken(nil)
    }
}
