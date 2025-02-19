//
//  LedgerCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class LedgerCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let ledgerVM = LedgerVM()
        let ledgerVC = LedgerVC(viewModel: ledgerVM)
        ledgerVC.coordinator = self
        ledgerVC.tabBarItem = UITabBarItem(title: Tab.ledger.title, image: Tab.ledger.icon, tag: 0)
        navigationController.setViewControllers([ledgerVC], animated: false)
    }
}
