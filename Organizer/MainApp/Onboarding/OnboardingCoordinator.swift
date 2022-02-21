//
//  OnboardingCoordinator.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit

// MARK: - Delegate
protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish(_ coordinator: OnboardingCoordinator)
}

// MARK: - Coordinator
/** A Coordinator which takes a user through the first-time user / onboarding flow. */

final class OnboardingCoordinator: NavigationCoordinator {

    weak var delegate: OnboardingCoordinatorDelegate?

    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController

    //    private let textAndButtonViewController: TextAndButtonViewController
    //
    init() {
        let onboardingVC = OnboardingVC()

        let navigationController = UINavigationController(rootViewController: onboardingVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }

    func start() {
        //textAndButtonViewController.delegate = self
    }

}

//// MARK: - Text and Button View Controller Delegate
//extension OnboardingCoordinator: TextAndButtonViewControllerDelegate {
//
//    func textAndButtonViewControllerDidTapButton(_ controller: TextAndButtonViewController) {
//        let summaryViewController = SummaryViewController()
//        summaryViewController.delegate = self
//        navigator.push(summaryViewController, animated: true)
//    }
//
//}
//
//// MARK: - Summary View Controller Delegate
//extension OnboardingCoordinator: SummaryViewControllerDelegate {
//
//    func summaryViewControllerDidTapButton(_ controller: SummaryViewController) {
//        delegate?.onboardingCoordinatorDidFinish(self)
//    }
//
//}
