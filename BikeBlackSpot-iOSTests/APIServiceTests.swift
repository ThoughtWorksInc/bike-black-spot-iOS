import Foundation
import Quick
import Nimble

class APIServiceTests : QuickSpec {
    override func spec() {
        describe("getCategories") {
            it("should return all report categories") {
                var done = false
                APIService.sharedInstance.getCategories()
                .then { object in
                    done = true
                }
                .catch { error in
                    fail("getCategories returned error")
                }
                expect(done).toEventually(beTrue())
            }
        }
    }
}
