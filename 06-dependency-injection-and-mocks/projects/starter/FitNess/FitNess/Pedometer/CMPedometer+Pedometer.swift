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
  
  func start() {
    startEventUpdates { event, error in
      
    }
  }
}
