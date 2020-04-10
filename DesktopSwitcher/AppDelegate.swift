//
//  AppDelegate.swift
//  DesktopSwitcher
//
//  Created by Jefferson Qin on 2020/4/8.
//  Copyright © 2020 Jefferson Qin. All rights reserved.
//

import Cocoa
import UserNotifications
import NotificationCenter

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {

    private var middleMouseDown: Bool = false
    private var preferenceWindow = PreferenceWindowController()
    private var lastTime: Int64 = 0
    private var count = 0
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBAction func quitButtonClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func preferenceButtonClicked(_ sender: NSMenuItem) {
        preferenceWindow.showWindow(sender)
    }
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound, .carPlay]) { (granted, error) in
            print("Premission Granted: \(granted)")
        }
        UNUserNotificationCenter.current().delegate = self
        statusItem.button?.title = "Desktop Switcher"
        statusItem.menu = statusMenu
        statusItem.button?.image = NSImage.init(named: "icon")

        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.leftMouseDown) { (event) in
            let thisTime = Date().milliStamp
            if thisTime - self.lastTime < 250 {
                self.count += 1
            } else {
                self.count = 1
            }
            self.lastTime = thisTime
            if (self.count == 4) {
                NSWorkspace.shared.launchApplication("D\(externalDesktopIndex)")
                NSWorkspace.shared.launchApplication("D\(desktopIndex)")
            }
        }
        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.otherMouseUp) { (event) in
            self.middleMouseDown = false
        }
        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.otherMouseDown) { (event) in
            self.middleMouseDown = true
        }
        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.scrollWheel) { (event) in
            if event.scrollingDeltaY > 1 && self.middleMouseDown {
                let content = UNMutableNotificationContent.init()
                content.title = NSString.localizedUserNotificationString(forKey: "Switch Sucess", arguments: nil)
                content.subtitle = NSString.localizedUserNotificationString(forKey: "Switched Left", arguments: nil)
                let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.1, repeats: false)
                let request = UNNotificationRequest.init(identifier: "backToHome", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    print("Error: \(String(describing: error))")
                }
                NSWorkspace.shared.launchApplication("DLeft")
                self.middleMouseDown = false
            } else if event.scrollingDeltaY < -1 && self.middleMouseDown {
                let content = UNMutableNotificationContent.init()
                content.title = NSString.localizedUserNotificationString(forKey: "Switch Sucess", arguments: nil)
                content.subtitle = NSString.localizedUserNotificationString(forKey: "Switched Right", arguments: nil)
                let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.1, repeats: false)
                let request = UNNotificationRequest.init(identifier: "backToHome", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    print("Error: \(String(describing: error))")
                }
                NSWorkspace.shared.launchApplication("DRight")
                self.middleMouseDown = false
            }
        }
    }

    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

