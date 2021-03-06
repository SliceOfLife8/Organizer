//
//  AppRootVC.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit

/** The app's root controller - a `UIViewController` which simply holds a child `UIViewController`. */

final class AppRootVC: UIViewController {

    func set(childViewController controller: UIViewController) {
        addChild(controller)
        controller.didMove(toParent: self)

        let childView = controller.view!
        view.addSubview(childView, constraints: [childView.topAnchor.constraint(equalTo: view.topAnchor),
                                                 childView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                                 childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                                 childView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }

}
