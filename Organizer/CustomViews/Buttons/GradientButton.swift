//
//  GradientButton.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 23/2/22.
//

import UIKit

class GradientButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSizes()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setSizes()
    }

    override open var intrinsicContentSize: CGSize {
            let intrinsicContentSize = super.intrinsicContentSize

            let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
            let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom

            return CGSize(width: adjustedWidth, height: adjustedHeight)
        }

    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = blend(cgColors: colors).cgColor
        gradientLayer.shadowOffset = CGSize(width: 2, height: 2)
        gradientLayer.shadowRadius = 4.0
        gradientLayer.shadowOpacity = 1.0
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.titleLabel?.flash(numberOfFlashes: .infinity)
        isHighlighted = false
    }

    private func blend(cgColors: [CGColor]) -> UIColor {
        let colors = cgColors.map { UIColor(cgColor: $0) }

        let componentsSum = colors.reduce((red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0))) { (temp, color) in
            guard let components = color.cgColor.components else { return temp }
            return (temp.0 + components[0], temp.1 + components[1], temp.2 + components[2])
        }
        let components = (red: componentsSum.red / CGFloat(colors.count) ,
                          green: componentsSum.green / CGFloat(colors.count),
                          blue: componentsSum.blue / CGFloat(colors.count))

        return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: 1)
    }

    private func setSizes() {
        sizeToFit()
        layer.cornerRadius = self.frame.height/2
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIImpactFeedbackGenerator.impact(.light)
    }

    override var isHighlighted: Bool {
        didSet {
            let newOpacity : Float = isHighlighted ? 0.6 : 0.85
            let newRadius : CGFloat = isHighlighted ? 6.0 : 4.0

            let shadowOpacityAnimation = CABasicAnimation()
            shadowOpacityAnimation.keyPath = "shadowOpacity"
            shadowOpacityAnimation.fromValue = layer.shadowOpacity
            shadowOpacityAnimation.toValue = newOpacity
            shadowOpacityAnimation.duration = 0.1

            let shadowRadiusAnimation = CABasicAnimation()
            shadowRadiusAnimation.keyPath = "shadowRadius"
            shadowRadiusAnimation.fromValue = layer.shadowRadius
            shadowRadiusAnimation.toValue = newRadius
            shadowRadiusAnimation.duration = 0.1

            layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
            layer.add(shadowRadiusAnimation, forKey: "shadowRadius")

            layer.shadowOpacity = newOpacity
            layer.shadowRadius = newRadius

            let xScale : CGFloat = isHighlighted ? 1.025 : 1.0
            let yScale : CGFloat = isHighlighted ? 1.05 : 1.0
            UIView.animate(withDuration: 0.1) {
                let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
                self.transform = transformation
            }
        }
    }
}
