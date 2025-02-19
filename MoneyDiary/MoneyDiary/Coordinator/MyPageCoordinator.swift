//
//  MyPageCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let myPageVM = MyPageVM()
        let myPageVC = MyPageVC(viewModel: myPageVM)
        myPageVC.coordinator = self
        myPageVC.tabBarItem = UITabBarItem(title: Tab.myPage.title, image: Tab.myPage.icon, tag: 3)
        navigationController.setViewControllers([myPageVC], animated: false)
    }
}
