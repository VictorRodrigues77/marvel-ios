//
//  CharactersController.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import UIKit

class CharactersController: BaseController {
    
    // MARK: - Outlets
    @IBOutlet private weak var charactersCollectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: CharactersViewModel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchCharacters()
    }
    
    override func initView() {
        super.initView()
        
        initTableView()
        initNavigation()
    }
    
    override func bindView() {
        super.bindView()
        
        viewModel.onHideLoading = { [weak self] () in
            DispatchQueue.main.async { self?.didHideLoading() }
        }
        
        viewModel.onShowLoading = { [weak self] () in
            DispatchQueue.main.async { self?.didShowLoading() }
        }
        
        viewModel.onFailureFetch = { [weak self] title, message in
            DispatchQueue.main.async { self?.didShow(title: title, message: message) }
        }
        
        viewModel.onSuccessFetch = { [weak self] () in
            DispatchQueue.main.async { self?.charactersCollectionView.reloadData() }
        }
        
        viewModel.onDidSelectRow = { [weak self] title, message in
            DispatchQueue.main.async { self?.didShow(title: title, message: message) }
        }
    }

}

extension CharactersController {
    private func initTableView() {
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        charactersCollectionView.register(
            UINib(
                nibName: "CharactersCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "CharactersCell"
        )
    }
    
    private func initNavigation() {
        title = "Characters"
    }
}

extension CharactersController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRowsInSection() - 20 {
            viewModel.fetchCharacters()
        }
    }
}

extension CharactersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

extension CharactersController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharactersCell", for: indexPath) as! CharactersCell
        cell.display(character: viewModel.cellForRow(at: indexPath.row))
        return cell
    }
}
