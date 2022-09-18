//
//  ComicsViewModel.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation

class ComicsViewModel {
    
    private let useCase: FetchComicsUseCase
    private let coordinator: ComicsCoordinator
    
    private var offset: Int = 0
    private var comics: [Comic] = []
    
    var onHideLoading: (() -> Void)?
    var onShowLoading: (() -> Void)?
    var onFailureFetch: ((String, String) -> Void)?
    var onSuccessFetch: (() -> Void)?
    var onDidSelectRow: ((String, String) -> Void)?
    
    init(useCase: FetchComicsUseCase,
         coordinator: ComicsCoordinator) {
        
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func fetchComics() {
        self.onShowLoading?()
        self.useCase.fetchComics(offset: self.offset) { [weak self] result in
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
    
    private func setPaginated(_ response: ComicResponse) {
        self.comics += response.data.results
        self.onSuccessFetch?()
        self.offset += 10
    }
    
    func didSelectRow(at index: Int) {
        self.onDidSelectRow?("Comic", comics[index].name)
    }
    
    func numberOfRowsInSection() -> Int {
        return comics.count
    }
    
    func cellForRow(at index: Int) -> Comic {
        return comics[index]
    }
    
}
