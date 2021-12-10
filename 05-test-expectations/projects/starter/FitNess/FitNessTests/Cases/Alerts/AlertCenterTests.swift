
import XCTest
@testable import FitNess

class AlertCenterTests: XCTestCase {
  //swiftlint:disable implicitly_unwrapped_optional
  var sut: AlertCenter!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AlertCenter()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  // MARK: - Tests
  
  func testPostOne_generatesANotification() {
    // given
    // Notificationが通知されることを期待する
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)
    let alert = Alert("this is an alert")
    
    // when
    sut.postAlert(alert: alert)

    // then
    wait(for: [exp], timeout: 1)
  }

}
