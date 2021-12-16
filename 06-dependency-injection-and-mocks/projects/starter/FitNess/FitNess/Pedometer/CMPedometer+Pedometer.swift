import Foundation
import CoreMotion

extension CMPedometer: Pedometer {
  func start() {
    startEventUpdates { event, error in
      
    }
  }
}
