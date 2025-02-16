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
    var tabBarController: UITabBarController
    
    var ledgerCoordinator: LedgerCoordinator
    var planCoordinator: PlanCoordinator
    var newsCoordinator: NewsCoordinator
    var myPageCoordinator: MyPageCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        
        self.ledgerCoordinator = LedgerCoordinator()
        self.planCoordinator = PlanCoordinator()
        self.newsCoordinator = NewsCoordinator()
        self.myPageCoordinator = MyPageCoordinator()
        
    }
    
    func start() {
        // 앱의 네비게이션 흐름을 초기화
        ledgerCoordinator.start()
        planCoordinator.start()
        newsCoordinator.start()
        myPageCoordinator.start()

        tabBarController.viewControllers = [
            ledgerCoordinator.navigationController,
            planCoordinator.navigationController,
            newsCoordinator.navigationController,
            myPageCoordinator.navigationController
        ]
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
}
