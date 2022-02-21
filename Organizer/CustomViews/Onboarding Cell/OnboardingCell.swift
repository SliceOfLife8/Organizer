//
//  OnboardingCell.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    static let identifier = String(describing: OnboardingCell.self)

    // MARK: - Outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    func setup(_ slide: OnboardingSlide) {
        mainImageView.image = slide.image
        titleLabel.text = slide.title
        descLabel.text = slide.description
    }

}
