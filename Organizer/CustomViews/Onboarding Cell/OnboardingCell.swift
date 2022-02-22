//
//  OnboardingCell.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit
import Lottie
import SDWebImageLottiePlugin

class OnboardingCell: UICollectionViewCell {

    static let identifier = String(describing: OnboardingCell.self)

    lazy var animationView: LOTAnimationView = {
        let animationView = LOTAnimationView()
        animationView.contentMode = .scaleAspectFit
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
        animationView.backgroundColor = .clear
        animationView.stop()
        animationView.sd_cancelCurrentImageLoad()
    }

    func configure(_ slide: OnboardingSlide) {
        titleLabel.text = slide.title
        descLabel.text = slide.description
    }

    func playAnimation(_ path: String) {
        let lottieUrl = URL(string: path)
        animationView.sd_setImage(with: lottieUrl) { (image, error, cacheType, url) in
            self.animationView.play()
        }
    }
}
