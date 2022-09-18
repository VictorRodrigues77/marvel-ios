//
//  CharactersCoordinator.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation
import UIKit

class CharactersCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .characters }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let charactersViewModel = CharactersViewModel(
            useCase: FetchCharactersUseCaseImpl(
                networkManager: NetworkManager<CharactersApi>()
            ),
            coordinator: self
        )
        let charactersController = CharactersController(
            nibName: "CharactersController",
            bundle: nil
        )
        charactersController.viewModel = charactersViewModel
        navigationController.pushViewController(
            charactersController,
            animated: true
        )
    }
    
    deinit {
        print("CharactersCoordinator deinit")
    }
    
}
