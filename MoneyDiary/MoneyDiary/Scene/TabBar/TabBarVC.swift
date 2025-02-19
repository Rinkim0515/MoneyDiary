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

final class TabBarVC: UITabBarController { // 커스텀 탭바를 적용하기위해 TabBarController 대신 사용
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
        setValue(CustomTabBar(), forKey: "tabBar")
    }
    


}

//MARK: - Binding VM
extension TabBarVC {
    private func bindViewModel() {
        viewModel.state
            .drive(onNext: { [weak self] state in
                
                self?.selectedIndex = state.selectedTab.rawValue // 현재 탭의 rawValue
            })
            .disposed(by: disposeBag)
        
        viewModel.event
            .emit(onNext: { [weak self] event in
                switch event {
                case .navigate(let tab):
                    self?.coordinator?.navigateTo(tab: tab)
                }
            })
            .disposed(by: disposeBag)
    }
}


final class CustomTabBar: UITabBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let tabBarHeight = UIHelper.dynamicHeight(baseRatio: 0.1, min: 60, max: 100)
        return CGSize(width: size.width, height: tabBarHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.tintColor = .systemRed
        self.backgroundColor = .white
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
