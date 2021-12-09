
import XCTest
@testable import FitNess

class DataModelTests: XCTestCase {

  // MARK: - Properties
  
  var sut: DataModel!

  
  // MARK: - Lifecycles
    
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = DataModel()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  // MARK: - Test
  
  // MARK: - Goal
  func testModel_whenStarted_goalIsNotReached() {
    XCTAssertFalse(sut.goalReached,
        "goalReached should be false when the model is created")
  }


}
