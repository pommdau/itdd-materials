import Foundation

class AlertCenter {
  static var instance = AlertCenter()
  
  // MARK: - Properties
  
  private var alertQueue: [Alert] = []
  
  var alertCount: Int {
    return alertQueue.count
  }
  
  // MARK: - Lifecycles

  init(center: NotificationCenter = .default) {
    self.notificationCenter = center
  }

  // MARK: - Notifications
  let notificationCenter: NotificationCenter

  func postAlert(alert: Alert) {
    guard !alertQueue.contains(alert) else { return }  // 同じアラートを2回表示しない
    alertQueue.append(alert)
    
    let notification = Notification(name: AlertNotification.name,
                                    object: self,
                                    userInfo: [AlertNotification.Keys.alert: alert])
    notificationCenter.post(notification)
  }
    
  // MARK: - Alert Handling

  func clearAlerts() {
    alertQueue.removeAll()
  }

}

// MARK: - Class Helpers

extension AlertCenter {
  
  class func listenForAlerts(
    _ callback: @escaping (AlertCenter) -> ()) {

    instance.notificationCenter
      .addObserver(forName: AlertNotification.name,
                   object: instance,
                   queue: .main) { _ in
      callback(instance)
    }
  }

}
