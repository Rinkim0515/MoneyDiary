//
//  PlanVM.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import Foundation

import RxSwift
import RxCocoa

enum PlanIntent {
    case planCreate
    case planDetail
    
}

enum PlanEvent {
    case navigatePlanDetail
    case naviagatePlanCreate
}

struct PlanState {
    let isLoaded: Bool
    let plans: [Plan]
}

struct Plan {
    
}


final class PlanVM {
    private let disposeBag = DisposeBag()
    
    let intentRelay = PublishRelay<PlanIntent>()
    private let eventRelay = PublishRelay<PlanEvent>()
    private let stateRelay = BehaviorRelay<PlanState>(value: .init(isLoaded: false, plans: []))
    
    var event: Signal<PlanEvent> { eventRelay.asSignal() }
    var state: Driver<PlanState> { stateRelay.asDriver() }
    
    
    
    init(){
        
    }
}
