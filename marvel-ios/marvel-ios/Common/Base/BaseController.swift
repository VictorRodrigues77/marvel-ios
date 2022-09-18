//
//  BaseController.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import UIKit

class BaseController: UIViewController {
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        view.backgroundColor = .lightGray
        view.center = self.view.center
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.alpha = 0.7
        return view
    }()
    
    private lazy var loadingActivity: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .large
        loading.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        loading.center = CGPoint(x: self.loadingView.bounds.size.width / 2, y: self.loadingView.bounds.size.height / 2)
        return loading
    }()
    
    open func initView() {}
    open func bindView() {}

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        bindView()
    }
    
    func didShow(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func didShowLoading() {
        DispatchQueue.main.async {
            self.loadingView.addSubview(self.loadingActivity)
            self.view.addSubview(self.loadingView)
            self.loadingActivity.startAnimating()
        }
    }
    
    func didHideLoading() {
        DispatchQueue.main.async {
            self.loadingActivity.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }

}
