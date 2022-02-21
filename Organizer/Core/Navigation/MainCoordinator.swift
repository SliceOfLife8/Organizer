//
//  MainCoordinator.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit

// MARK: - MainCoordinator
final class MainCoordinator: NavigationCoordinator {

    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController

    private let examplesViewController: FirstVC

    init() {
        let examplesViewController = FirstVC()
        self.examplesViewController = examplesViewController

        let navigationController = UINavigationController(rootViewController: examplesViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }

    func start() {
        //rootViewController.delegate = self
    }

}
