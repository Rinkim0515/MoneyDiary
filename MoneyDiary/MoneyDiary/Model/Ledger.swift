//
//  Ledger.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit
protocol ledgerAdaptor {
    
}

enum ledgerIntent {
    case tapCell
    case tapBudget
    case tapAdd
    
}

enum ledgerEvent {
    case naviagateTo(AnyObject)
    case navigateToDetail(Date)
    
}

struct ledgerState {
    let isUpdated: Bool
    let calendarItem: [CalendarItem]
    let date: Date
    
}

struct CalendarItem {
    var date: Date = Date()
    var dayBudget: Int = 0
    var isThisMonth: Bool = false
    var weekSection: Int = 0
    var backgroundColor: UIColor = .white
    var dailyIncome: Int = 0
    var dailyExpense: Int = 0
    var totalAmount: Int = 0
    var dayType: Int = 0 // 1 = Sun ~ 7 = Sat
}


