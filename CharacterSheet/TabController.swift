//
//  TabController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 08/12/23.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTab()
    }

    private func setupTab() {
        let cats = self.createNav(with: "Cats", and: UIImage(systemName: "cat.fill"), vc: CatsViewController())
        let dogs = self.createNav(with: "Dogs", and: UIImage(systemName: "dog.fill"), vc: DogsViewController())
        let info = self.createNav(with: "Dogs", and: UIImage(systemName: "info.circle.fill"), vc: DogsViewController())
        self.setViewControllers([cats,dogs, info], animated: true)
    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
//        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        return nav
    }
}
