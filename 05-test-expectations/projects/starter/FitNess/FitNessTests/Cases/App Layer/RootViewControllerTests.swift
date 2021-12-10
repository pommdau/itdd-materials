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

  func testWhenAlertsPosted_alertContainerIsShown() {
    // given
    let exp = expectation(forNotification: AlertNotification.name,
                          object: nil,
                          handler: nil)
    let alert = Alert("show the container")

    // when
    AlertCenter.instance.postAlert(alert: alert)

    // then
    wait(for: [exp], timeout: 1)
    XCTAssertFalse(sut.alertContainer.isHidden)
  }

}
