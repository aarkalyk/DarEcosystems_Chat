//
//  NSDateExtension.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import UIKit

extension NSDate{
    static func dateStringFrom(date : NSDate) -> String{
        let fmt = DateFormatter()
        fmt.timeStyle = .none
        fmt.dateStyle = .short
        fmt.doesRelativeDateFormatting = true
        return fmt.string(from: date as Date)
    }
    
    static func timeStringFrom(date : NSDate) -> String{
        let fmt = DateFormatter()
        fmt.timeStyle = .short
        fmt.dateStyle = .none
        fmt.doesRelativeDateFormatting = true
        return fmt.string(from: date as Date)
    }
}
