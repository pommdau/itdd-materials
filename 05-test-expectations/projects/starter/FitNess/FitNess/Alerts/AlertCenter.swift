import Foundation

class AlertCenter {
  static var instance = AlertCenter()
  
  private var alertQueue: [Alert] = []

  init(center: NotificationCenter = .default) {
    self.notificationCenter = center
  }

  // MARK: - Notifications
  let notificationCenter: NotificationCenter

  func postAlert(alert: Alert) {
    guard !alertQueue.contains(alert) else { return }  // 同じアラートを2回表示しない
    alertQueue.append(alert)
    
    let notification = Notification(name: AlertNotification.name,
                                    object: self)
    notificationCenter.post(notification)
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
