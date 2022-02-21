//
//  UIImpactFeedbackGenerator+Extensions.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit

extension UIImpactFeedbackGenerator {
    static func impact(_ style: FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
