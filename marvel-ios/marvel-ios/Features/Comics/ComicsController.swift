//
//  ComicsController.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import UIKit

class ComicsController: BaseController {
    
    // MARK: - Outlets
    @IBOutlet private weak var comicsCollectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: ComicsViewModel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchComics()
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
            DispatchQueue.main.async { self?.comicsCollectionView.reloadData() }
        }
        
        viewModel.onDidSelectRow = { [weak self] title, message in
            DispatchQueue.main.async { self?.didShow(title: title, message: message) }
        }
    }

}

extension ComicsController {
    private func initTableView() {
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        comicsCollectionView.register(
            UINib(
                nibName: "ComicsCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "ComicsCell"
        )
    }
    
    private func initNavigation() {
        title = "Comics"
    }
}

extension ComicsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRowsInSection() - 20 {
            viewModel.fetchComics()
        }
    }
}

extension ComicsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

extension ComicsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicsCell", for: indexPath) as! ComicsCell
        cell.display(comic: viewModel.cellForRow(at: indexPath.row))
        return cell
    }
}
