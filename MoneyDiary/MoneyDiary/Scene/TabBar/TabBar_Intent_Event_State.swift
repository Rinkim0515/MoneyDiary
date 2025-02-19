//
//  TabBar_Intent_Event_State.swift
//  MoneyDiary
//
//  Created by KimRin on 2/19/25.
//

import Foundation
import UIKit

enum Tab: Int, CaseIterable {
    case ledger = 0
    case plan
    case news
    case myPage
    
    var title: String {
        switch self {
        case .ledger: return "가계부"
        case .plan: return "재무 목표"
        case .news: return "경제 뉴스"
        case .myPage: return "마이 페이지"
        }
    }
    var icon: UIImage? {
        switch self {
        case .ledger: return UIImage(systemName: "calendar")
        case .plan: return UIImage(systemName: "figure.mixed.cardio")
        case .news: return UIImage(systemName: "newspaper")
        case .myPage: return UIImage(systemName: "person.fill")
        }
    }
}

enum TabBarIntent {
    case selectTab(Tab)
}

enum TabBarEvent {
    case navigate(Tab)
}


struct TabBarState {
    let isLoaded: Bool = true
    let selectedTab: Tab
    
    static let initial = TabBarState(selectedTab: .ledger)
}
