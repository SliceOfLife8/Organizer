//
//  OnboardingCell.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit
import Lottie

class OnboardingCell: UICollectionViewCell {

    static let identifier = String(describing: OnboardingCell.self)

    private lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.loopMode = .loop
        animationView.clipsToBounds = true
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .forceFinish
        return animationView
    }()

    // MARK: - Outlets
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lottieView.addSubview(animationView, constraints: [lottieView.topAnchor.constraint(equalTo: animationView.topAnchor),
                                                           lottieView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor),
                                                           lottieView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor),
                                                           lottieView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor)])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        //animationView.stop()
        self.layer.sublayers?.removeAll()
    }

    func configure(_ slide: OnboardingSlide) {
        titleLabel.text = slide.title
        descLabel.text = slide.description
        animationView.animation = Animation.named(slide.animation.rawValue)
        //animationView.play()
    }
}
