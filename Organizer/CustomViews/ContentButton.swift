//
//  ContentButton.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit

class ContentButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setupButton() {
        setSizes()
        if isEnabled {
            setEnabledState()
        } else {
            setDisableState()
        }
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                setEnabledState()
            } else {
                setDisableState()
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            UIImpactFeedbackGenerator.impact(.light)
        })
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.transform = .identity
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.transform = .identity
    }

    func setEnabledState(bgColor: UIColor = .black, titleColor: UIColor = UIColor(hexString: "#EDEDED")) {
        backgroundColor = bgColor
        setTitleColor(titleColor, for: .normal)
        titleLabel?.textColor = titleColor
        titleLabel?.font = .systemFont(ofSize: 16)
    }

    func setDisableState(bgColor: UIColor = UIColor(hexString: "#EDEDED"), titleColor: UIColor = UIColor(hexString: "#949494")) {
        backgroundColor = bgColor
        setTitleColor(titleColor, for: .disabled)
        titleLabel?.textColor = titleColor
        titleLabel?.font = .systemFont(ofSize: 16)
    }

    private func setSizes() {
        contentEdgeInsets = UIEdgeInsets(top: 11, left: 18, bottom: 11, right: 18)
        sizeToFit()
        layer.cornerRadius = 8
    }

}
