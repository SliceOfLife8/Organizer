//
//  UIView+Extensions.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 20/2/22.
//

import UIKit

//  MARK: - Closure Configuration
//  These methods provide some syntactic sugar for configuring views with closures.
protocol ClosureConfigurable { }
extension ClosureConfigurable where Self: UIView {

    /**
     Inititalizes any `UIView` subclass with a closure for configuration.
     - Parameter configure: The closure for configuring the view.
     */

    init(_ configure: (Self) -> Void) {
        self.init(frame: .zero)
        configure(self)
    }

    /**
     Provides a closure for configuring any `UIView` subclass.
     - Parameter configuration: The closure for configuring the view.
     */

    func applying(configuration configure: (Self) -> Void) -> Self {
        configure(self)
        return self
    }

}
extension UIView: ClosureConfigurable { }

// MARK: - Auto Layout Helpers
extension UIView {

    /** Convenience method for programatically adding a subview with constraints. */

    func addSubview(_ view: UIView, constraints: [NSLayoutConstraint]) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    func flash(numberOfFlashes: Float) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.8
        flash.fromValue = 1
        flash.toValue = 0.2
        flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = numberOfFlashes
        layer.add(flash, forKey: nil)
    }
}
