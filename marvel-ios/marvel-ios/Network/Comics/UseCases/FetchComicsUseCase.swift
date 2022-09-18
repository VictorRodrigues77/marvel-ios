//
//  FetchComicsUseCase.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation

protocol FetchComicsUseCase {
    func fetchComics(offset: Int, completion: @escaping (Result<ComicResponse, Error>) -> Void)
}

final class FetchComicsUseCaseImpl: FetchComicsUseCase {
    
    private let networkManager: NetworkManager<ComicsApi>
    
    init(networkManager: NetworkManager<ComicsApi>) {
        self.networkManager = networkManager
    }
    
    func fetchComics(offset: Int, completion: @escaping (Result<ComicResponse, Error>) -> Void) {
        self.networkManager.request(target: .comics(offset: offset), completion: completion)
    }
    
}
