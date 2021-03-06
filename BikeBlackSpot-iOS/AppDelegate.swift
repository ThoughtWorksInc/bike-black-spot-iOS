import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var reachability:Reachability?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [
        NSObject: AnyObject]?) -> Bool {
            return launchApplication()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return launchApplication()
    }
    
    func launchApplication() -> Bool{
        //Add your google maps key here
        GMSServices.provideAPIKey(gMapsKey)
        Styles.apply()
        
        reachability = Reachability.reachabilityForInternetConnection()
        if !reachability!.isReachable() {
            showErrorViewController()
        }
        startReachabilityMonitoring()
        
        Categories.loadCategories()
        return true
    }
    
    func startReachabilityMonitoring() {
        
        reachability!.whenReachable = { reachability in
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
            Categories.resetNumberOfAttempts()
            if Categories.isNotLoaded() {
                Categories.loadCategories()
            }
            self.showDefaultViewController()
        }
        reachability!.whenUnreachable = { reachability in
            println("Not reachable")
            self.showErrorViewController()
        }
        reachability!.startNotifier()
    }
    
    func showDefaultViewController() {
        var storyboard = UIStoryboard(name:"Main", bundle:nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController() as? UIViewController
    }
    
    func showErrorViewController() {
        var storyboard = UIStoryboard(name:"Main", bundle:nil)
        self.window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("ErrorViewController") as? UIViewController
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if Categories.isNotLoaded() {
            Categories.resetNumberOfAttempts()
            Categories.loadCategories()
        }
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

