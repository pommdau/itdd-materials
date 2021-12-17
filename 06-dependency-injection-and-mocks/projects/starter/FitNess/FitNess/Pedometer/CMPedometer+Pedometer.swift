import Foundation
import CoreMotion

extension CMPedometer: Pedometer {
  
  // MARK: - Properties
  
  var pedometerAvailable: Bool {
    return CMPedometer.isStepCountingAvailable() &&
      CMPedometer.isDistanceAvailable() &&
      CMPedometer.authorizationStatus() != .restricted
  }
  
  var permissionDeclined: Bool {
    return CMPedometer.authorizationStatus() == .denied
  }
  
  // MARK: - Function
  
  func start(
    dataUpdates: @escaping (PedometerData?, Error?) -> Void,
    eventUpdates: @escaping (Error?) -> Void) {

    startEventUpdates { event, error in
      eventUpdates(error)
    }

    startUpdates(from: Date()) { data, error in
      dataUpdates(data, error)
    }
  }

}

extension CMPedometerData: PedometerData {

  var steps: Int {
    return numberOfSteps.intValue
  }

  var distanceTravelled: Double {
    return distance?.doubleValue ?? 0
  }
}
