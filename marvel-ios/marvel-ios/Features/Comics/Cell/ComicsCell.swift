//
//  ComicsCell.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 17/09/22.
//

import UIKit

class ComicsCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var comicImage: UIImageView!
    @IBOutlet private weak var comicName: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initLayout()
    }
    
    // MARK: - Display
    func display(comic: Comic) {
        self.comicImage.kf.setImage(with: comic.getImage())
        self.comicName.text = comic.name
    }
    
}

extension ComicsCell {
    private func initLayout() {
        self.comicImage.layer.cornerRadius = 10
        self.comicImage.layer.masksToBounds = true
    }
}
