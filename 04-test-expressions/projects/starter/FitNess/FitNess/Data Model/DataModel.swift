import Foundation


class DataModel {
  
  // MARK: - Properties
  
  var goalReached: Bool {
    if let goal = goal,
      steps >= goal {
        return true
    }
    return false
  }

  var goal: Int?
  var steps: Int = 0
  
  // MARK: - Lifecycles
  
  // MARK: - Helpers
  
}
