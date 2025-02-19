//
//  BudgetVC.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
// 매달 소비 예산/ 지출예산 설정하기

import UIKit
import RxSwift
import RxCocoa

final class BudgetVC: UIViewController {
    private let viewModel: BudgetVM
    private let mainView = BudgetView()
    private let disposeBag = DisposeBag()
    var coordinator: Coordinator?
    
    //MARK: - ViewLifeCylcle
    init(viewModel: BudgetVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        
    }

    
    private func subscribe() {
        self.rx.viewWillappear
            .subscribe(onNext: { _ in
            })
            .disposed(by: disposeBag)
        
        
    }
}
