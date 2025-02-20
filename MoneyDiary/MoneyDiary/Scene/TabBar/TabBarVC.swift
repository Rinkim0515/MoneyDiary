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
    private var titleString = " "
    
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
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        tabBar.tintColor = .systemRed
        

    
    }
    


}

//MARK: - Binding VM
extension TabBarVC {
    private func bindViewModel() {
        viewModel.state
            .drive(onNext: { [weak self] state in
                
                self?.selectedIndex = state.selectedTab.rawValue // 현재 탭의 rawValue
                self?.title = state.selectedTab.title
                
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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              let tab = Tab(rawValue: index) else { return }
        
        viewModel.intentRelay.accept(.selectTab(tab))
    }

}



extension UITabBar {
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }

}

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
