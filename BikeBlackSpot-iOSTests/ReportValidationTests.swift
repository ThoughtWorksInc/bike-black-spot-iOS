import Foundation
import Quick
import Nimble

class ReportValidationTests : QuickSpec {
    override func spec() {
        describe("report field validation") {
            
            var viewModel = ReportViewModel()
            
            it("should fail on invalid email address") {
                var valid = viewModel.isValid(ReportField.Email, value: "hello world")
                expect(valid).to(beFalse())
            }
            
            it("should pass on valid email address") {
                
            }
            
            it("should validate email field") {
                
            }
        }
    }
}