//
//  FetchCharactersUseCase.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation

protocol FetchCharactersUseCase {
    func fetchCharacters(offset: Int, completion: @escaping (Result<CharacterResponse, Error>) -> Void)
}

final class FetchCharactersUseCaseImpl: FetchCharactersUseCase {
    
    private let networkManager: NetworkManager<CharactersApi>
    
    init(networkManager: NetworkManager<CharactersApi>) {
        self.networkManager = networkManager
    }
    
    func fetchCharacters(offset: Int, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        self.networkManager.request(target: .characters(offset: offset), completion: completion)
    }
    
}
