//
//  LedgerVC.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit



class LedgerVC: UIViewController {
    private let viewModel: LedgerVM
    private let mainView = LedgerView()
    private let disposeBag = DisposeBag()
    var coordinator: Coordinator?
    
    //MARK: - ViewLifeCylcle
    init(viewModel: LedgerVM) {
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
