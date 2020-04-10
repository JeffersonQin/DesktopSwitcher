//
//  PreferenceWindowController.swift
//  DesktopSwitcher
//
//  Created by Jefferson Qin on 2020/4/9.
//  Copyright © 2020 Jefferson Qin. All rights reserved.
//

import Cocoa

var desktopIndex = 1
var externalDesktopIndex = 6

class PreferenceWindowController: NSWindowController {

    @IBOutlet var desktopTextField: NSTextField!
    
    @IBOutlet var externalDesktopTextField: NSTextField!
    
    @IBAction func configureButtonTouched(_ sender: Any) {
        var num = desktopTextField.cell!.title
        if num == "1" || num == "2" || num == "3" || num == "4" || num == "5" || num == "6" || num == "7" || num == "8" || num == "9" || num == "10" {
            desktopIndex = Int(num)!
        }
        num = externalDesktopTextField.cell!.title
        if num == "1" || num == "2" || num == "3" || num == "4" || num == "5" || num == "6" || num == "7" || num == "8" || num == "9" || num == "10" {
            externalDesktopIndex = Int(num)!
        }
    }
    
    override var windowNibName : String! {
        return "PreferenceWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
}
