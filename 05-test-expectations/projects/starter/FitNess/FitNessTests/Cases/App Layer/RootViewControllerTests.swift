import XCTest
@testable import FitNess

class RootViewControllerTests: XCTestCase {
  
  var sut: RootViewController!
  
  override func setUp() {
    super.setUp()
    sut = getRootViewController()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Alert Container

  func testWhenLoaded_noAlertsAreShown() {
    XCTAssertTrue(sut.alertContainer.isHidden)
  }

    
}
