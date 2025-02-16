//
//  NewsCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class NewsCoordinator: Coordinator {
    var navigationController: UINavigationController
    

    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let newsVM = NewsVM()
        let newsVC = NewsVC(viewModel: newsVM)
        newsVC.coordinator = self
        navigationController.setViewControllers([newsVC], animated: false)
    }
}
