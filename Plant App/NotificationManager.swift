//
//  NotificationManager.swift
//  Plant App
//
//  Created by You on 28/10/2025.
//

import Foundation
import UserNotifications

// قواعد تكرار بسيطة للتذكير بالسقاية
public enum WateringRepeatRule: Equatable {
    case onceAfter(seconds: TimeInterval)                  // للتجربة: بعد مدة قصيرة
    case everyNDays(Int, atHour: Int = 9, minute: Int = 0) // يومياً أو كل N أيام
}

public struct NotificationManager {
    public static let shared = NotificationManager()
    private init() {}

    // طلب الإذن من المستخدم لإرسال الإشعارات
    @discardableResult
    public func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            )
            return granted
        } catch {
            print("Notification authorization error: \(error)")
            return false
        }
    }

    // جدولة تذكير سقاية لنبتة باسمها
    public func scheduleWaterReminder(
        for plantName: String,
        rule: WateringRepeatRule,
        identifier: String? = nil,
        title: String = "Time to water your plant 💧",
        bodyPrefix: String = "Don’t forget to water"
    ) async {
        let center = UNUserNotificationCenter.current()

        // تأكد من وجود إذن
        let settings = await center.notificationSettings()
        if settings.authorizationStatus != .authorized {
            let granted = await requestAuthorization()
            if !granted { return }
        }

        // محتوى الإشعار
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "\(bodyPrefix) \(plantName)."
        content.sound = .default

        // اختيار المشغل (الترغر)
        let trigger: UNNotificationTrigger
        switch rule {
        case .onceAfter(let seconds):
            let interval = max(1, seconds)
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)

        case .everyNDays(let n, let hour, let minute):
            if n <= 1 {
                // تذكير يومي عند ساعة محددة
                var comps = DateComponents()
                comps.hour = hour
                comps.minute = minute
                trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            } else {
                // كل N أيام باستخدام interval مكرر
                // ملاحظة: التكرار بـ UNTimeIntervalNotificationTrigger يعمل حتى بالخلفية.
                let interval = TimeInterval(n * 24 * 60 * 60)
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
            }
        }

        // مَعَرِّف فريد اختياري، افتراضياً مبني على اسم النبتة
        let id = (identifier ?? "water.\(plantName)")
            .replacingOccurrences(of: " ", with: "_")

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        do {
            try await center.add(request)
            print("Scheduled notification for \(plantName) with id: \(id)")
        } catch {
            print("Failed to schedule notification: \(error)")
        }
    }

    // إلغاء تذكير لنبتة محددة (يعتمد على نفس المعرف)
    public func cancelReminder(for plantName: String) {
        let id = "water.\(plantName)".replacingOccurrences(of: " ", with: "_")
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }

    // إلغاء جميع التذكيرات المعلّقة
    public func cancelAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
