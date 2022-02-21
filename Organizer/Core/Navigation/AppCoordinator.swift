//
//  AppCoordinator.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit

/** The application's root `Coordinator`. */

final class AppCoordinator: PresentationCoordinator {

    var childCoordinators: [Coordinator] = []
    var rootViewController = AppRootVC()

    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
        self.route(isFirstTimeUser: true)
    }

}

// MARK: - Routing
private extension AppCoordinator {

    func route(isFirstTimeUser: Bool) {
        if isFirstTimeUser {
            let onboardingCoordinator = OnboardingCoordinator()
            onboardingCoordinator.delegate = self
            onboardingCoordinator.rootViewController.isModalInPresentation = true
            presentCoordinator(onboardingCoordinator, animated: false)
        } else {
            let examplesCoordinator = MainCoordinator()
            addChildCoordinator(examplesCoordinator)
            examplesCoordinator.start()
            rootViewController.set(childViewController: examplesCoordinator.rootViewController)
        }
    }

}

// MARK: - Onboarding Coordinator Delegate
extension AppCoordinator: OnboardingCoordinatorDelegate {

    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator) {
        let isFirstTimeUser = false // update userDefaults
        route(isFirstTimeUser: isFirstTimeUser)

        dismissCoordinator(coordinator, animated: true)
    }

}
