
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
    AlertCenter.instance.clearAlerts()
    sut = nil
    try super.tearDownWithError()
  }
  
  // MARK: - Alert Count

  func testWhenInitialized_AlertCountIsZero() {
    XCTAssertEqual(sut.alertCount, 0)
  }
  
  func testWhenAlertPosted_CountIsIncreased() {
    // given
    let alert = Alert("An alert")

    // when
    sut.postAlert(alert: alert)

    // then
    XCTAssertEqual(sut.alertCount, 1)
  }

  func testWhenCleared_CountIsZero() {
    // given
    let alert = Alert("An alert")
    sut.postAlert(alert: alert)

    // when
    sut.clearAlerts()

    // then
    XCTAssertEqual(sut.alertCount, 0)
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
  
  func testPostingTwoAlerts_generatesTwoNotifications() {
    //given
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)
    exp.expectedFulfillmentCount = 2
  
    let alert1 = Alert("this is the first alert")
    let alert2 = Alert("this is the second alert")

    // when
    sut.postAlert(alert: alert1)
    sut.postAlert(alert: alert2)

    // then
    wait(for: [exp], timeout: 1)
  }

  func testPostDouble_generatesOnlyOneNotification() {
    //given
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)
    exp.expectedFulfillmentCount = 2
    exp.isInverted = true  // 期待値の反転
    let alert = Alert("this is an alert")

    // when
    sut.postAlert(alert: alert)
    sut.postAlert(alert: alert)

    // then
    wait(for: [exp], timeout: 1)
  }
  
  // MARK: - Notification Contents

  func testNotification_whenPosted_containsAlertObject() {
    // given
    let alert = Alert("test contents")
    let exp = expectation(forNotification: AlertNotification.name,
                          object: sut,
                          handler: nil)

    var postedAlert: Alert?
    sut.notificationCenter.addObserver(forName: AlertNotification.name,
                                       object: sut,
                                       queue: nil) { notification in
      let info = notification.userInfo
      postedAlert = info?[AlertNotification.Keys.alert] as? Alert
    }

    // when
    sut.postAlert(alert: alert)  // userinfoにAlertオブジェクトを含める

    // then
    wait(for: [exp], timeout: 1)
    XCTAssertNotNil(postedAlert, "should have sent an alert")
    XCTAssertEqual(alert,
                   postedAlert,
                   "should have sent the original alert")
  }


}
