//
//  CharactersViewModel.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation

class CharactersViewModel {
    
    private let useCase: FetchCharactersUseCase
    private let coordinator: CharactersCoordinator
    
    private var offset: Int = 0
    private var characters: [Character] = []
    
    var onHideLoading: (() -> Void)?
    var onShowLoading: (() -> Void)?
    var onFailureFetch: ((String, String) -> Void)?
    var onSuccessFetch: (() -> Void)?
    var onDidSelectRow: ((String, String) -> Void)?
    
    init(useCase: FetchCharactersUseCase,
         coordinator: CharactersCoordinator) {
        
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func fetchCharacters() {
        self.onShowLoading?()
        self.useCase.fetchCharacters(offset: self.offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.onHideLoading?()
                self?.setPaginated(response)
            case .failure(let error):
                self?.onHideLoading?()
                self?.onFailureFetch?("Error", error.localizedDescription)
            }
        }
    }
    
    private func setPaginated(_ response: CharacterResponse) {
        self.characters += response.data.results
        self.onSuccessFetch?()
        self.offset += 10
    }
    
    func didSelectRow(at index: Int) {
        self.onDidSelectRow?("Character", characters[index].name)
    }
    
    func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    func cellForRow(at index: Int) -> Character {
        return characters[index]
    }
    
}
