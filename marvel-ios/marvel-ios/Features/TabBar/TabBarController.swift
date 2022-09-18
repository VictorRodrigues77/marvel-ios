//
//  TabBarController.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = UIViewController()
        let tabOneBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(
                named: "character_tabbar_icon.png"
            ),
            selectedImage: UIImage(
                named: "character_tabbar_icon.png"
            )
        )
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UIViewController()
        let tabTwoBarItem = UITabBarItem(
            title: "Comics",
            image: UIImage(
                named: "comic_tabbar_icon.png"
            ),
            selectedImage: UIImage(
                named: "comic_tabbar_icon.png"
            )
        )
        tabTwo.tabBarItem = tabTwoBarItem
           
        self.viewControllers = [tabOne, tabTwo]
    }

}
