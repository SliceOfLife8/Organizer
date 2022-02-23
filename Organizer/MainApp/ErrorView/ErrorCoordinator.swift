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

    init(_ error: GenericError) {
        #warning("fix me")
        let colors = [UIColor.init(hexString: "#2B95CE").cgColor, UIColor.init(hexString: "#2ECAD5").cgColor]
        let model = ErrorModel(image: UIImage(systemName: "person"), title: "Person", description: "subtitle", buttonTitle: "go to the moon!", buttonColors: colors)
        viewModel = ErrorViewModel(model)
        let errorVC = ErrorVC(viewModel)

        let navigationController = UINavigationController(rootViewController: errorVC)
        navigationController.navigationBar.isHidden = true
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }

    func start() {
        viewModel.delegate = self
    }

//    private func createModel(error: GenericError) -> ErrorModel {
//        switch error {
//        case .calendarNoPermission:
//            return ErrorModel(image: UIImage(systemName: "person"), title: "Person", description: "subtitle", buttonTitle: "go to the moon!")
//        }
//    }

}

extension ErrorCoordinator: ErrorVMDelegate {
    func buttonTapped() {
        print("show alert dialog!")
    }
}
