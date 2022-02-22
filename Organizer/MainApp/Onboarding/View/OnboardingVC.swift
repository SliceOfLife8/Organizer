//
//  OnboardingVC.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit
import AVFoundation

class OnboardingVC: BaseVC {

    @IBOutlet weak var nextButton: ContentButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            if currentPage != oldValue {
                self.soundEffect(resourceName: "page-flip")
            }
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 { // lastPage
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(restartAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)

        slides = [
            OnboardingSlide(title: "Organise your day!", description: "Keeping track of events. You do not want to miss anything!", animation: .calendar),
            OnboardingSlide(title: "Reminder", description: "Synchronize the app with the calendar in order to receive proper notifications.", animation: .notifications),
            OnboardingSlide(title: "Make the app yours!", description: "You can customize the app through a variety of options. Do not hesitate! It's totally free!", animation: .settings),
            OnboardingSlide(title: "Almost done!", description: "Please we need access in order to modify your calendar.", animation: .rocket)
        ]

        setupCollectionView()
        pageControl.numberOfPages = slides.count
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: OnboardingCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func slideToNextPage() {
        if currentPage == slides.count - 1 {
            print("go to next page!")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    @objc
    private func restartAnimation() {
        let visibleCell = collectionView.cellForItem(at: IndexPath(row: currentPage, section: 0)) as? OnboardingCell
        visibleCell?.animationView.play()
    }
    
}

extension OnboardingVC: UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        let slide = slides[indexPath.row]
        cell.configure(slide)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let _cell = cell as? OnboardingCell {
            let slide = slides[indexPath.row]
            if !_cell.animationView.isAnimationPlaying {
                _cell.playAnimation(slide.animation.url)
                _cell.animationView.loopAnimation = true
            }
            if slide.animation == .rocket {
                _cell.animationView.backgroundColor = UIColor(hexString: "#527D9F").withAlphaComponent(0.8)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let _cell = cell as? OnboardingCell {
            _cell.animationView.stop()
        }
    }
}
