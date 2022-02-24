//
//  AppCoordinator.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit
import EventKit

/** The application's root `Coordinator`. */

final class AppCoordinator: PresentationCoordinator {

    var childCoordinators: [Coordinator] = []
    var rootViewController = AppRootVC()

    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
        let hasUserSeenOnboardingFlow = LocalStorageManager.shared.retrieve(forKey: .onboarding, type: Bool.self)

        if hasUserSeenOnboardingFlow == true { // Check about 'Event' permission
            let store = EKEventStore()

            store.requestAccess(to: .event, completion: { granded, error in
                DispatchQueue.main.async {
                    if granded {
                        self.route(isFirstTimeUser: false)
                    } else {
                        self.showError()
                    }
                }
            })
        } else {
            self.route(isFirstTimeUser: true)
        }
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

    func showError(withAnimation animated: Bool = false) {
        let errorCoodinator = ErrorCoordinator(.calendarNoPermission)
        errorCoodinator.delegate = self
        presentCoordinator(errorCoodinator, modalStyle: .fullScreen, animated: animated)
    }
    
}

// MARK: - Onboarding Coordinator Delegate
extension AppCoordinator: OnboardingCoordinatorDelegate {

    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator, userIsGranted: Bool) {
        LocalStorageManager.shared.save(true,
                                        forKey: .onboarding,
                                        withMethod: .userDefaults)

        if userIsGranted {
            route(isFirstTimeUser: false)

            dismissCoordinator(coordinator, modalStyle: .flipHorizontal, animated: true)
        } else {
            dismissCoordinator(coordinator, animated: false, completion: {
                self.showError(withAnimation: true)
            })
        }
    }

}

// MARK: - Error Coordinator Delegate
extension AppCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(_ coordinator: OnboardingCoordinator) {
        route(isFirstTimeUser: false)
        dismissCoordinator(coordinator, animated: true)
    }
}
