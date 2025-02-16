//
//  TabBarVM.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import Foundation
import RxSwift
import RxCocoa

enum Tab {
    case ledger
    case plan
    case news
    case myPage
}

enum TabBarIntent {
    case selectTab(Tab)
}

enum TabBarEvent {
    case navigate(Tab)
}


struct TabBarState {
    let isLoaded: Bool
    let selectedTab: Tab
    
    static let initial = TabBarState(isLoaded: false, selectedTab: .ledger)
}

final class TabBarVM {
    private let disposeBag = DisposeBag()
    
    let intentRelay = PublishRelay<TabBarIntent>()
    private let eventRelay = PublishRelay<TabBarEvent>()
    private let stateRelay = BehaviorRelay<TabBarState>(value: .initial)
    
    var state: Driver<TabBarState> { stateRelay.asDriver() }
    var event: Signal<TabBarEvent> { eventRelay.asSignal() }
    
    
    init() {
        bindIntent()
    }
    
    private func bindIntent() {
        intentRelay
            .subscribe(onNext: { [weak self] intent in
                guard let self = self else { return }
                switch intent {
                case .selectTab(let tab):
                    let newState = TabBarState(isLoaded: true, selectedTab: tab)
                    self.stateRelay.accept(newState)
                    self.eventRelay.accept(.navigate(tab))
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    
}
