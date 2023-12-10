//
//  WrapperViewController.swift
//  CharacterSheet
//
//  Created by Cicero Nascimento on 09/12/23.
//

import Foundation
import UIKit

class WrapperViewController: UITabBarController {
    let catViewController: UIViewController
    let dogViewController: UIViewController

    init(catViewController: UIViewController, dogViewController: UIViewController) {
        self.catViewController = catViewController
        self.dogViewController = dogViewController
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTab()
    }

    private func setupTab() {
        let cats = self.createNav(with: "Cats", and: UIImage(systemName: "cat.fill"), vc: catViewController)
        let dogs = self.createNav(with: "Dogs", and: UIImage(systemName: "dog.fill"), vc: dogViewController)
        self.setViewControllers([cats, dogs], animated: true)
    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.prefersLargeTitles = true
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
}


