import Foundation
import Quick
import Nimble

class ReportValidationTests : QuickSpec {
    override func spec() {
        describe("report field validation") {
            var viewModel = ReportViewModel()
            
            describe("name:") {
                it("should pass on valid name") {
                    var valid = viewModel.isValid(ReportField.Name, value: "test name here")
                    expect(valid).to(beTrue())
                }
                
                it("should fail on empty name") {
                    var valid = viewModel.isValid(ReportField.Name, value: "")
                    expect(valid).to(beFalse())
                }
            }
            describe("email:") {
                it("should pass on valid email address") {
                    var valid = viewModel.isValid(ReportField.Email, value: "testing@gmail.com")
                    expect(valid).to(beTrue())
                }
                
                it("should fail on invalid email address. (no @)") {
                    var valid = viewModel.isValid(ReportField.Email, value: "hello-world.com")
                    expect(valid).to(beFalse())
                }
                
                it("should fail on invalid email address. (no .)") {
                    var valid = viewModel.isValid(ReportField.Email, value: "hello@worldcom")
                    expect(valid).to(beFalse())
                }
                
                it("should fail on invalid email address. (has spaces)") {
                    var valid = viewModel.isValid(ReportField.Email, value: "hello world@gmail.com")
                    expect(valid).to(beFalse())
                }
                
                it("should fail on invalid email address. (has only spaces)") {
                    var valid = viewModel.isValid(ReportField.Email, value: " ")
                    expect(valid).to(beFalse())
                }
                
                it("should fail on invalid email address. (no email)") {
                    var valid = viewModel.isValid(ReportField.Email, value: "")
                    expect(valid).to(beFalse())
                }
            }
            describe("Postcode:") {
                it("Should allow valid postcode") {
                    var valid = viewModel.isValid(ReportField.Postcode, value: "1234")
                    expect(valid).to(beTrue())
                }
                
                it("Should allow empty postcode") {
                    var valid = viewModel.isValid(ReportField.Postcode, value: "")
                    expect(valid).to(beTrue())
                }
                
                it("Should fail when postcode is more than 4 numbers") {
                    var valid = viewModel.isValid(ReportField.Postcode, value: "12341")
                    expect(valid).to(beFalse())
                }
                
                it("Should fail when postcode is less than 4 numbers") {
                    var valid = viewModel.isValid(ReportField.Postcode, value: "121")
                    expect(valid).to(beFalse())
                }
                
                it("Should fail when postcode is not numbers (letters)") {
                    var valid = viewModel.isValid(ReportField.Postcode, value: "aaaaa")
                    expect(valid).to(beFalse())
                }
                
                it("Should fail when postcode is not numbers (symbols)") {
                    var valid = viewModel.isValid(ReportField.Postcode, value: "12-3")
                    expect(valid).to(beFalse())
                }
            }
        }
    }
}