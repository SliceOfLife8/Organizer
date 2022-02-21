//
//  OnboardingVC.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import UIKit
import AVFoundation

// #527D9F

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

        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from diffent culture around the world", animation: .calendar),
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from diffent culture around the world", animation: .event),
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from diffent culture around the world", animation: .calendar),
            OnboardingSlide(title: "Delicious Dishes!!", description: "Experience a variety of amazing dishes from diffent culture around the world", animation: .event)
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
}
