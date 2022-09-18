//
//  CharactersCell.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import UIKit
import Kingfisher

class CharactersCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var characterName: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initLayout()
    }
    
    // MARK: - Display
    func display(character: Character) {
        self.characterImage.kf.setImage(with: character.getImage())
        self.characterName.text = character.name
    }
    
}

extension CharactersCell {
    private func initLayout() {
        self.characterImage.layer.cornerRadius = 10
        self.characterImage.layer.masksToBounds = true
    }
}
