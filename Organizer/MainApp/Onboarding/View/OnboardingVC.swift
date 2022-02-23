//
//  OnboardingVC.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import RxSwift

class OnboardingVC: BaseVC {
    // MARK: - Vars
    private(set) var viewModel: OnboardingViewModel
    private let disposeBag = DisposeBag()

    // MARK: - Outlets
    @IBOutlet weak var nextButton: ContentButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - Inits
    init(_ viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        collectionViewEvents()
    }

    override func setupBindables() {
        viewModel.output.slides
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: OnboardingCell.identifier, cellType: OnboardingCell.self)) { (_, slide, cell) in
                cell.configure(slide)
            }
            .disposed(by: disposeBag)
    }

    override func setupRxEvents() {
        NotificationCenter.default
            .rx.notification(UIApplication.willEnterForegroundNotification, object: nil)
            .subscribe(onNext: { _ in
                let row = try? self.viewModel.input.currentPage.value()
                let visibleCell = self.collectionView.cellForItem(at: IndexPath(row: row ?? 0, section: 0)) as? OnboardingCell
                visibleCell?.animationView.play()
            })
            .disposed(by: disposeBag)

        nextButton.rx
            .tap
            .subscribe(onNext: {
                if let index = self.viewModel.getPageIndex() {
                    let indexPath = IndexPath(item: index, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    override func setupUI() {
        pageControl.numberOfPages = (try? viewModel.output.slides.value().count) ?? 0
        pageControl.currentPageIndicatorTintColor = UIColor.appColor(.primary)

        viewModel.input.currentPage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { page in
                if self.pageControl.currentPage != page { // Old value
                    self.soundEffect(resourceName: "page-flip")
                }

                self.pageControl.currentPage = page
                /// Check if user is on lastPage and show proper title for button
                let lastPage = page == self.collectionView.numberOfItems(inSection: 0) - 1
                self.nextButton.setTitle(lastPage ? "Get Started" : "Next", for: .normal)
            })
            .disposed(by: disposeBag)
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: OnboardingCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension OnboardingVC: UICollectionViewDelegateFlowLayout {
    private func collectionViewEvents() {
        collectionView.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .map { ($0.cell as? OnboardingCell,
                    try? self.viewModel.output.slides.value()[safe: $0.at.row]) }
            .subscribe(onNext: { (cell, slide) in
                if let _slide = slide {
                    if cell?.animationView.isAnimationPlaying == false {
                        cell?.playAnimation(_slide.animation.url)
                        cell?.animationView.loopAnimation = true
                    }
                    if _slide.animation == .rocket {
                        cell?.animationView.backgroundColor = UIColor.appColor(.primary).withAlphaComponent(0.8)
                    }
                }
            })
            .disposed(by: disposeBag)

        collectionView.rx.didEndDecelerating
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                let width = self.collectionView.frame.width
                let page = Int(self.collectionView.contentOffset.x / width)
                self.viewModel.input.currentPage.onNext(page)
            })
            .disposed(by: disposeBag)

        collectionView.rx.didEndDisplayingCell
            .observe(on: MainScheduler.instance)
            .map { $0.cell as? OnboardingCell }
            .subscribe(onNext: { cell in
                cell?.animationView.stop()
            })
            .disposed(by: disposeBag)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
