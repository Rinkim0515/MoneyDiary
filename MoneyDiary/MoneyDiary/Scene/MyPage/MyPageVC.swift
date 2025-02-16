//
//  MyPageVC.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
// 그래프 통계보기 : 매월 소비량, 수입량 비교차트
// 현재 총 자산 보기
// 소비 추이 분석받기 ( GPT로 요청 ) -> 분석
// 미래 예상 자산 그래프 

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class MyPageVC: UIViewController {
    private let viewModel: MyPageVM
    private let mainView = UIView()
    private let disposeBag = DisposeBag()
    var coordinator: Coordinator
    
    init(viewModel: MyPageVM) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
