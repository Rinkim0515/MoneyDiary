//
//  HomeCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit



final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    //탭 간 화면 전환을 담당하는 컨테이너의 역할, 탭을 전환할 때마다 새로운 UIViewController를 직접 추가하는 불필요한 작업을 줄일 수 있다.
    private let tabBarVC: TabBarVC
    private let tabBarVM: TabBarVM
    
    var ledgerCoordinator: LedgerCoordinator
    var planCoordinator: PlanCoordinator
    var newsCoordinator: NewsCoordinator
    var myPageCoordinator: MyPageCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarVM = TabBarVM()
        self.tabBarVC = TabBarVC(viewModel: tabBarVM)
        
        
        self.ledgerCoordinator = LedgerCoordinator()
        self.planCoordinator = PlanCoordinator()
        self.newsCoordinator = NewsCoordinator()
        self.myPageCoordinator = MyPageCoordinator()

        self.tabBarVC.coordinator = self

    }
    
    func start() {
        // 앱의 네비게이션 흐름을 초기화
        ledgerCoordinator.start()
        planCoordinator.start()
        newsCoordinator.start()
        myPageCoordinator.start()

        tabBarVC.setViewControllers([
            ledgerCoordinator.navigationController,
            planCoordinator.navigationController,
            newsCoordinator.navigationController,
            myPageCoordinator.navigationController
        ], animated: false)
        
        navigationController.setViewControllers([tabBarVC], animated: false)
    }
    
    //MARK: - Navigate

    
    func viewController(for tab: Tab) -> UIViewController {
        switch tab {
        case .ledger: return ledgerCoordinator.navigationController
        case .plan: return planCoordinator.navigationController
        case .news: return newsCoordinator.navigationController
        case .myPage: return myPageCoordinator.navigationController
        }
    }
    
    func navigateTo(tab: Tab) {
        tabBarVC.selectedIndex = tab.rawValue
    }
}
