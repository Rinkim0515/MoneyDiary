//
//  HomeCoordinator.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        
    }
    
    func start() {
        <#code#>
    }
}
