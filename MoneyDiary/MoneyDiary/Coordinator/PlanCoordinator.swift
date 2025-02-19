//
//  PlanCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class PlanCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    

    
    func start() {
        let planVM = PlanVM()
        let planVC = PlanVC(viewModel: planVM)
        planVC.coordinator = self
        planVC.tabBarItem = UITabBarItem(title: Tab.plan.title, image: Tab.plan.icon, tag: 1)
        navigationController.setViewControllers([planVC], animated: false)
    }
}
