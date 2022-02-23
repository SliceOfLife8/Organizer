//
//  OnboardingCoordinator.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit
import EventKit

// MARK: - Delegate
protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator, userIsGranted: Bool)
}

// MARK: - Coordinator
/** A Coordinator which takes a user through the first-time user / onboarding flow. */

final class OnboardingCoordinator: NavigationCoordinator {

    weak var delegate: OnboardingCoordinatorDelegate?

    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController

    private let onboardingViewModel: OnboardingViewModel

    init() {
        onboardingViewModel = OnboardingViewModel()
        let onboardingVC = OnboardingVC(onboardingViewModel)

        let navigationController = UINavigationController(rootViewController: onboardingVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }

    func start() {
        onboardingViewModel.delegate = self
    }

}

extension OnboardingCoordinator: OnboardingVMDelegate {
    func getStartedTapped() {
        let store = EKEventStore()

        store.requestAccess(to: .event, completion: { granded, error in
            DispatchQueue.main.async {
                self.delegate?.onboardingCoordinatorDidFinish(self, userIsGranted: granded)
            }
        })
    }
}
