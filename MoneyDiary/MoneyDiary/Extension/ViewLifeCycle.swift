//
//  ViewLifeCycle.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillappear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ in true }
    }
}
