import Foundation


class DataModel {
  
  // MARK: - Properties
  
  var goalReached: Bool {
    if let goal = goal,
      steps >= goal, !caught {
        return true
    }
    return false
  }


  var goal: Int?
  var steps: Int = 0
  
  // MARK: - Properties for Nessie

  let nessie = Nessie()
  var distance: Double = 0

  var caught: Bool {
    return distance > 0 && nessie.distance >= distance
  }

  // MARK: - Lifecycles
  
  // MARK: - Helpers
  
}
