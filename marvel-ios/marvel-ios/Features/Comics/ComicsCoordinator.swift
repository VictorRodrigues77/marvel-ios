//
//  ComicsCoordinator.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation
import UIKit

class ComicsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .characters }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let comicsViewModel = ComicsViewModel(
            useCase: FetchComicsUseCaseImpl(
                networkManager: NetworkManager<ComicsApi>()
            ),
            coordinator: self
        )
        let comicsController = ComicsController(
            nibName: "ComicsController",
            bundle: nil
        )
        comicsController.viewModel = comicsViewModel
        navigationController.pushViewController(
            comicsController,
            animated: true
        )
    }
    
    deinit {
        print("CharactersCoordinator deinit")
    }
    
}

