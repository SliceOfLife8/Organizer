//
//  OnboardingViewModel.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 22/2/22.
//

import RxSwift
import RxCocoa

/**
 What’s great about this solution is that Input and Output are strongly typed with OnboardingViewModel.Input. It also doesn’t allow an access to the properties without going through Input and Output. Finally, by keeping the protocol to the ViewModel, we can still inject our component to a View by using CurrencyViewModelType as well as mock behavior in Unit Test. source: https://benoitpasquier.com/rxswift-mvvm-alternative-structure-for-viewmodel/
 */

protocol OnboardingVMType {
    associatedtype OnboardingInput
    associatedtype OnboardingOutput

    var input : OnboardingInput { get }
    var output : OnboardingOutput { get }
}

protocol OnboardingVMDelegate: AnyObject {
    func getStartedTapped()
}

final class OnboardingViewModel: OnboardingVMType {
    var input: OnboardingInput
    var output: OnboardingOutput
    // MARK: - Inputs
    struct OnboardingInput {
        var currentPage: BehaviorSubject<Int>
    }
    // MARK: - Outputs
    struct OnboardingOutput {
        var slides: BehaviorSubject<[OnboardingSlide]>
    }

    private let disposeBag = DisposeBag()
    weak var delegate: OnboardingVMDelegate?

    init() {
        let slidesArray = BehaviorSubject(value: [
            OnboardingSlide(title: "Organise your day!", description: "Keeping track of events. You do not want to miss anything!", animation: .calendar),
            OnboardingSlide(title: "Reminder", description: "Synchronize the app with the calendar in order to receive proper notifications.", animation: .notifications),
            OnboardingSlide(title: "Make the app yours!", description: "You can customize the app through a variety of options. Do not hesitate! It's totally free!", animation: .settings),
            OnboardingSlide(title: "Almost done!", description: "Please we need access in order to modify your calendar.", animation: .rocket)
        ])

        self.input = OnboardingInput(currentPage: BehaviorSubject(value: 0))
        self.output = OnboardingOutput(slides: slidesArray)
    }

    func getPageIndex() -> Int? {
        let numberOfSlides = (try? output.slides.value().count) ?? 0
        let currentPageIndex = try? input.currentPage.value()
        if currentPageIndex == numberOfSlides - 1 {
            self.delegate?.getStartedTapped()
            return nil
        } else {
            let currentValue = (try? input.currentPage.value()) ?? 0
            input.currentPage.onNext(currentValue + 1)
            return (currentValue + 1)
        }
    }

}
