import Foundation
import Quick
import Nimble

let TIMEOUT_INTERVAL_IN_SECS = 10.0

class APIServiceTests : QuickSpec {
    override func spec() {
        var category:ReportCategory?
        var userToken:String?
        
        context("Categories") {
            describe("getCategories") {
                it("should return all report categories") {
                    var categories:[ReportCategory] = []
                    APIService.sharedInstance.getCategories()
                        .then { result -> Void in
                            categories = result
                            category = categories.first
                        }
                        .catch { error in
                            fail("getCategories returned error")
                    }
                    // this test seems to take longer to return thus longer timeout
                    let timeout = 10.0
                    expect(categories).toNotEventually(beEmpty(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                    expect(category).toNotEventually(beNil(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                    expect(category?.uuid).toNotEventually(beNil(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                    expect(category?.name).toNotEventually(beNil(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                    expect(category?.desc).toNotEventually(beNil(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                }
            }
        }
        
        context("User") {
            var user = User()
            beforeEach {
                user.name = "John Smith"
                user.email = "jsmith@mail.com"
                user.postcode = "3000"
            }
            
            describe("registerUser") {
                
                it("should return UUID on valid user") {
                    var result:String? = nil
                    APIService.sharedInstance.registerUser(user)
                        .then { uuid -> Void in
                            result = uuid
                            userToken = uuid
                        }
                        .catch { error in
                            fail()
                    }
                    expect(result).toNotEventually(beEmpty(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                }
            }
            
            describe("registerUser") {
                it("should return UUID on empty postcode") {
                    user.postcode = ""
                    var result:String? = nil
                    APIService.sharedInstance.registerUser(user)
                        .then { uuid in
                            result = uuid
                        }
                        .catch { error in
                            fail()
                    }
                    expect(result).toNotEventually(beEmpty(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                }
            }
            
            describe("registerUser") {
                it("should return error on empty email") {
                    user.email = ""
                    var result:String?
                    var errorCaught = false
                    APIService.sharedInstance.registerUser(user)
                        .then { uuid in
                            result = uuid
                        }
                        .catch { error in
                            errorCaught = true
                    }
                    expect(errorCaught).toEventually(beTrue(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                    expect(result).to(beNil())
                }
            }
            
            describe("registerUser") {
                it("should return error on invalid params") {
                    user.email = "hello"
                    user.postcode = "hello"
                    var result:String?
                    var errorCaught = false
                    APIService.sharedInstance.registerUser(user)
                        .then { uuid -> Void in
                            result = uuid
                        }
                        .catch { error in
                            errorCaught = true
                    }
                    expect(errorCaught).toEventually(beTrue(), timeout:TIMEOUT_INTERVAL_IN_SECS)
                    expect(result).to(beNil())
                }
            }
        }
        
        context("Report") {
            
            // create default report
            var report:Report!
            beforeEach {
                report = Report()
                report.userUUID = userToken
                report.location = Location(latitude: Constants.DEFAULT_MAP_LAT, longitude: Constants.DEFAULT_MAP_LONG, description: "")
                report.category = category
            }
            
            it("should create a new report without an image") {
                var success = false
                APIService.sharedInstance.createReport(report)
                    .then { result -> Void in
                        success = result
                    }
                    .catch { error in
                }
                expect(success).toEventually(beTrue(), timeout:TIMEOUT_INTERVAL_IN_SECS)

            }
            
            it("should create a new report with an image") {
                var success = false
                let imageUrl = NSBundle(forClass: APIServiceTests.self).pathForResource("image", ofType:"png")
                let data = NSData(contentsOfFile: imageUrl!)
                report.image = data
                APIService.sharedInstance.createReport(report)
                    .then { result -> Void in
                        success = result
                    }
                    .catch { error in
                }
                expect(success).toEventually(beTrue(), timeout:TIMEOUT_INTERVAL_IN_SECS)
            }
        }
    }
}