//
//  Period.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 26/2/2565 BE.
//

import Foundation

enum Period {
    case day
    case week
    case month
    
    var valueInDay: Int {
        switch self {
        case .day:
            return 1
        case .week:
            return 7
        case .month:
            return 30
        }
    }
}
