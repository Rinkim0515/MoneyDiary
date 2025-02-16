//
//  LedgerCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class LedgerCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let ledgerVM = LedgerVM()
        let ledgerVC = LedgerVC(viewModel: ledgerVM)
        ledgerVC.coordinator = self
        navigationController.setViewControllers([ledgerVC], animated: false)
    }
}
