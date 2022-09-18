//
//  AppCoordinator.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation
import UIKit

class AppCoordinator {

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .tab }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        let tabCoordinator = TabCoordinator.init(
            navigationController: navigationController
        )
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
    
}
