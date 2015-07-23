import Foundation
import Quick
import Nimble

let TIMEOUT_INTERVAL_IN_SECS = 3.0

class APIServiceTests : QuickSpec {
    override func spec() {
        describe("getCategories") {
            it("should return all report categories") {
                var categories:[ReportCategory] = []
                APIService.sharedInstance.getCategories()
                .then { result in
                    categories = result
                }
                .catch { error in
                    fail("getCategories returned error")
                }
                expect(categories).toNotEventually(beEmpty(), timeout:TIMEOUT_INTERVAL_IN_SECS)
            }
        }
    }
}
