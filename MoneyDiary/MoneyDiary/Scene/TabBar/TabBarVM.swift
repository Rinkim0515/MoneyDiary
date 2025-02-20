//
//  TabBarVM.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import Foundation


import RxSwift
import RxCocoa



final class TabBarVM {
    private let disposeBag = DisposeBag()
    
    let intentRelay = PublishRelay<TabBarIntent>()
    private let eventRelay = PublishRelay<TabBarEvent>() //coordinator에서 구독할 예정
    private let stateRelay = BehaviorRelay<TabBarState>(value: .initial)
    
    var state: Driver<TabBarState> { stateRelay.asDriver() }
    var event: Signal<TabBarEvent> { eventRelay.asSignal() }
    
    
    init() {
        bindIntent()
    }
    deinit {
        print("소멸")
    }
    
    private func bindIntent() {
        intentRelay
            .subscribe(onNext: { [weak self] intent in
                guard let self = self else { return }
                switch intent {
                case .selectTab(let tab):
                    let newState = TabBarState(selectedTab: tab)
                    self.stateRelay.accept(newState)
                    print(newState)
                    self.eventRelay.accept(.navigate(tab))
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    
}
