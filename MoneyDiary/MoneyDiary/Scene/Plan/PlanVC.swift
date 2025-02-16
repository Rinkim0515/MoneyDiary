//
//  PlanVC.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
/*
 목표 설정하기
 시작날짜, 모은금액, 종료날짜, 목표 금액
 */

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class PlanVC: UIViewController {
    private let viewModel: PlanVM
    private let mainView = UIView()
    private let disposeBag = DisposeBag()
    var coordinator: Coordinator
    
    init(viewModel: PlanVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
