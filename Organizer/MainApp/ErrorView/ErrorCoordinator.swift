//
//  ErrorCoordinator.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 23/2/22.
//

import UIKit

enum GenericError {
    case calendarNoPermission
}

// MARK: - Delegate
protocol ErrorCoordinatorDelegate: AnyObject {
    func errorCoordinatorDidFinish(_ coordinator: OnboardingCoordinator)
}

// MARK: - Coordinator
/** A Coordinator which takes a user through the first-time user / onboarding flow. */

final class ErrorCoordinator: NavigationCoordinator {

    weak var delegate: ErrorCoordinatorDelegate?

    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController

    private let viewModel: ErrorViewModel
    private let error: GenericError

    init(_ error: GenericError) {
        self.error = error
        let model = ErrorCoordinator.createModel(error: error)
        self.viewModel = ErrorViewModel(model)
        let errorVC = ErrorVC(viewModel)

        let navigationController = UINavigationController(rootViewController: errorVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }

    func start() {
        viewModel.delegate = self
    }

    private static func createModel(error: GenericError) -> ErrorModel {
        switch error {
        case .calendarNoPermission:
            let colors = [UIColor.init(hexString: "#614385").cgColor, UIColor.init(hexString: "#516395").cgColor]
            return ErrorModel(image: UIImage(named: "spacecraft"), title: "You don't have access", description: "It seems that you haven't given access to edit your calendars. To create fast and modify your daily events, press here! 👇", buttonTitle: "Open settings", buttonColors: colors)
        }
    }

}

extension ErrorCoordinator: ErrorVMDelegate {
    // Add all actions here
    func buttonTapped() {
        switch error {
        case .calendarNoPermission:
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        }
    }
}
