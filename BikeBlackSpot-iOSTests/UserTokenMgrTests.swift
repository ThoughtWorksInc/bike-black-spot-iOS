import Foundation
import Quick
import Nimble

class UserTokenMgrTests : QuickSpec {
    override func spec() {
        
        var user = User()
        beforeEach {
            user.name = "John Smith"
            user.email = "jsmith@mail.com"
            user.postcode = "3000"
            UserTokenMgr.sharedInstance.reset()
        }
        
        describe("UserTokenMgr") {
            it("should save UUID on successful registration") {
                var result:String? = nil
                APIService.sharedInstance.registerUser(user)
                    .then { uuid in
                        result = uuid
                    }
                    .catch { error in
                        fail()
                }
                expect(result).toNotEventually(beEmpty(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                expect(UserTokenMgr.sharedInstance.hasToken()).toEventually(beTrue(), timeout: TIMEOUT_INTERVAL_IN_SECS)
                expect(UserTokenMgr.sharedInstance.token()).toNotEventually(beNil(), timeout: TIMEOUT_INTERVAL_IN_SECS)
            }
        }
    }
}
