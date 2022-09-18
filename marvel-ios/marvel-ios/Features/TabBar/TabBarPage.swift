//
//  TabBarPage.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation
import UIKit

enum TabBarPage {
    case characters
    case comics

    init?(index: Int) {
        switch index {
        case 0:
            self = .characters
        case 1:
            self = .comics
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .characters:
            return "Characters"
        case .comics:
            return "Comics"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .characters:
            return 0
        case .comics:
            return 1
        }
    }
    
    func pageSelectedImage() -> UIImage {
        switch self {
        case .characters:
            return UIImage(named: "character_tabbar_icon.png")!
        case .comics:
            return UIImage(named: "comic_tabbar_icon.png")!
        }
    }
}
