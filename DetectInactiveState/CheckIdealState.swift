//
//  CheckIdealState.swift
//  Skal User
//
//  Created by Hxtreme on 2021-04-15.
//  Copyright © 2021 Appieatz Instant Food Delivery. All rights reserved.
//

import UIKit
import Foundation

extension NSNotification.Name {
    public static let TimeOutUserInteraction: NSNotification.Name = NSNotification.Name(rawValue: "TimeOutUserInteraction")
}

class CheckIdealState: UIApplication {

    static let ApplicationDidTimoutNotification = "AppTimout"

    // The timeout in seconds for when to fire the idle timer.

    let timeoutInSeconds: TimeInterval = 1 * 60 //5 * 60 //
    var idleTimer: Timer?

    // Listen for any touch. If the screen receives a touch, the timer is reset.

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        if let touches = event.allTouches {
            for touch in touches {
                if touch.phase == UITouch.Phase.began {
                    self.resetIdleTimer()
                }
            }
        }
    }

    // Resent the timer because there was user interaction.

    func resetIdleTimer() {

        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds, target: self, selector: #selector(self.idleTimerExceeded), userInfo: nil, repeats: false)

    }

    // If the timer reaches the limit as defined in timeoutInSeconds, post this notification.
    
    @objc func idleTimerExceeded() {

        print("Time Out")
         NotificationCenter.default.post(name:Notification.Name.TimeOutUserInteraction, object: nil)
    }

}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
