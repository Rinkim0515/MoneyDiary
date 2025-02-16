//
//  PlanCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class PlanCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let planVM = PlanVM()
        let planVC = PlanVC(viewModel: planVM)
        planVC.coordinator = self
        navigationController.setViewControllers([planVC], animated: false)
    }
}
