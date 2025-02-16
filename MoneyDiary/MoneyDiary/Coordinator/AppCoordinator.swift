//
//  AppCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
// 추후에 로그인 기능까지 확장해서 고려했을때 인증요구를 필요로 하기때문에 이렇게 구성

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController
    var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        // 로그인 & 비로그인
        if isUserAuthenticated() {
            showMainTabBar()
        } else {
            showAuthScrren()
        }
        
    }
    
    private func showMainTabBar() {
        tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator?.start()
    }
    
    private func showAuthScrren() {
        
    }
    
    private func isUserAuthenticated() -> Bool {
        true
    }
}
