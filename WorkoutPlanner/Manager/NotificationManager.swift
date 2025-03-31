import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            } else {
                print(granted ? "Notifications authorized" : "Notifications not authorized")
            }
        }
    }

    func scheduleNotification(for workoutName: String, in seconds: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Workout Reminder"
        content.body = "Don't forget your workout: \(workoutName)"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled in \(seconds) seconds for \(workoutName)")
            }
        }
    }
}
