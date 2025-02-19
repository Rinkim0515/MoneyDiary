//
//  NewsCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class NewsCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    

    

    
    func start() {
        let newsVM = NewsVM()
        let newsVC = NewsVC(viewModel: newsVM)
        newsVC.coordinator = self
        newsVC.tabBarItem = UITabBarItem(title: Tab.news.title, image: Tab.news.icon, tag: 2)
        navigationController.setViewControllers([newsVC], animated: false)
    }
}
