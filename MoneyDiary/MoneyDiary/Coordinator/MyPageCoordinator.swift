//
//  MyPageCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    var navigationController: UINavigationController
    

    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let myPageVM = MyPageVM()
        let myPageVC = MyPageVC(viewModel: myPageVM)
        myPageVC.coordinator = self
        navigationController.setViewControllers([myPageVC], animated: false)
    }
}
