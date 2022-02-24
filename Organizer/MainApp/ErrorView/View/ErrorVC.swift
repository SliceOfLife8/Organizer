//
//  ErrorVC.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 23/2/22.
//

import RxSwift

class ErrorVC: BaseVC {
    // MARK: - Vars
    private(set) var viewModel: ErrorViewModel
    private let disposeBag = DisposeBag()

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var mainButton: GradientButton!

    // MARK: - Inits
    init(_ viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupBindables() {
        viewModel.output
            .data
            .map { $0.title }
            .bind(to: mainTitle.rx.text)
            .disposed(by: disposeBag)

        viewModel.output
            .data
            .map { $0.description }
            .bind(to: subtitle.rx.text)
            .disposed(by: disposeBag)

        viewModel.output
            .data
            .map { $0.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.output
            .data
            .map { $0.buttonTitle }
            .bind(to: mainButton.rx.title())
            .disposed(by: disposeBag)

        viewModel.output
            .data
            .map { $0.buttonColors }
            .subscribe(onNext: { colors in
                self.mainButton.applyGradient(colors: colors)
            })
            .disposed(by: disposeBag)
    }

    override func setupRxEvents() {
        mainButton.rx
            .tap
            .subscribe(onNext: {
                self.viewModel.delegate?.buttonTapped()
            })
            .disposed(by: disposeBag)

        NotificationCenter.default
            .rx.notification(UIApplication.willEnterForegroundNotification, object: nil)
            .subscribe(onNext: { _ in
                self.mainButton.titleLabel?.flash(numberOfFlashes: .infinity)
            })
            .disposed(by: disposeBag)
    }
}
