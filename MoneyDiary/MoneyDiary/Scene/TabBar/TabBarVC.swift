//
//  TabBarVC.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class TabBarVC: UIViewController { // 커스텀 탭바를 적용하기위해 TabBarController 대신 사용
    private let tabBarView = TabBarView()
    
    private let viewModel: TabBarVM
    private let disposeBag = DisposeBag()
    weak var coordinator: TabBarCoordinator?
    
    //MARK: - View LifeCycle
    init(viewModel: TabBarVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    private func setupUI() {
        view.addSubview(tabBarView)
        tabBarView.backgroundColor = .white
        tabBarView.layer.cornerRadius = 10
        tabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] //왼쪽상단, 오른쪽 상단만 둥글게
        tabBarView.layer.shadowOpacity = 0.2
        tabBarView.layer.shadowRadius = 5
        // 기종별 동적 높이 할당
        let tabBarHeight = UIHelper.dynamicHeight(baseRatio: 0.1, min: 60, max: 80)
        tabBarView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(tabBarHeight)
        }
    }
    private func bindViewModel() {
        tabBarView.ledgerButton.rx.tap
            .map { TabBarIntent.selectTab(.ledger) }
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)

        tabBarView.planButton.rx.tap
            .map { TabBarIntent.selectTab(.plan) }
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)

        tabBarView.newsButton.rx.tap
            .map { TabBarIntent.selectTab(.news) }
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)

        tabBarView.myPageButton.rx.tap
            .map { TabBarIntent.selectTab(.myPage) }
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)

        viewModel.state
            .drive(onNext: { [weak self] state in
                self?.updateUI(for: state)
            })
            .disposed(by: disposeBag)
    }
    private func updateUI(for state: TabBarState) {
        switch state.selectedTab {
        case .ledger:
            coordinator?.navigationController
            print("가계부 화면으로 이동")
        case .plan:
            print("재무 목표 화면으로 이동")
        case .news:
            print("경제 뉴스 화면으로 이동")
        case .myPage:
            print("마이 페이지 화면으로 이동")
        }
    }
}

final class TabBarView: UIView {
    let ledgerButton = UIComponent.buttonWithTitle(title: "가계부", imageName: "calendar")
    let planButton = UIComponent.buttonWithTitle(title: "재무 목표", imageName: "figure.mixed.cardio")
    let newsButton = UIComponent.buttonWithTitle(title: "경제 뉴스", imageName: "newspaper")
    let myPageButton = UIComponent.buttonWithTitle(title: "마이 페이지", imageName: "person.fill")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5

        let stackView = UIStackView(arrangedSubviews: [ledgerButton, planButton, newsButton, myPageButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}
