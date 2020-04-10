//
//  TimeExtension.swift
//  DesktopSwitcher
//
//  Created by Jefferson Qin on 2020/4/9.
//  Copyright © 2020 Jefferson Qin. All rights reserved.
//

import Foundation

extension Date {
    
    var milliStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval * 1000))
        return millisecond
    }
    
}
