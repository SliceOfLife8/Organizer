//
//  OnboardingViewModel.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 22/2/22.
//

import RxSwift
import RxCocoa

protocol OnboardingVMInputs: AnyObject {
    var currentPage: BehaviorSubject<Int> { get set }
}

protocol OnboardingVMOutputs {
    var slides: BehaviorSubject<[OnboardingSlide]> { get }
}

protocol OnboardingVMType {
    var inputs: OnboardingVMInputs { get }
    var outputs: OnboardingVMOutputs { get }
}

final class OnboardingViewModel: OnboardingVMType, OnboardingVMInputs, OnboardingVMOutputs {
    var inputs: OnboardingVMInputs { return self }
    var outputs: OnboardingVMOutputs { return self }

    // MARK: - Inputs
    var currentPage: BehaviorSubject<Int> = BehaviorSubject(value: 0)

    // MARK: - Outputs
    var slides: BehaviorSubject<[OnboardingSlide]>

    private let disposeBag = DisposeBag()

    init() {
        self.slides = BehaviorSubject(value: [
            OnboardingSlide(title: "Organise your day!", description: "Keeping track of events. You do not want to miss anything!", animation: .calendar),
            OnboardingSlide(title: "Reminder", description: "Synchronize the app with the calendar in order to receive proper notifications.", animation: .notifications),
            OnboardingSlide(title: "Make the app yours!", description: "You can customize the app through a variety of options. Do not hesitate! It's totally free!", animation: .settings),
            OnboardingSlide(title: "Almost done!", description: "Please we need access in order to modify your calendar.", animation: .rocket)
        ])
    }

    func getPageIndex() -> Int? {
        let numberOfSlides = (try? slides.value().count) ?? 0
        let currentPageIndex = try? currentPage.value()
        if currentPageIndex == numberOfSlides - 1 {
            print("go to nextPage!")
            return nil
        } else {
            let currentValue = (try? currentPage.value()) ?? 0
            currentPage.onNext(currentValue + 1)
            return (currentValue + 1)
        }
    }

}
