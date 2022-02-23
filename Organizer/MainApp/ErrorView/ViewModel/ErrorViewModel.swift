//
//  ErrorViewModel.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 23/2/22.
//

import RxSwift
import RxCocoa

protocol ErrorVMType {
    associatedtype ErrorInput
    associatedtype ErrorOutput

    var input : ErrorInput { get }
    var output : ErrorOutput { get }
}

protocol ErrorVMDelegate: AnyObject {
    func buttonTapped()
}

final class ErrorViewModel: ErrorVMType {
    var input: ErrorInput
    var output: ErrorOutput
    // MARK: - Inputs
    struct ErrorInput {
        func buttonIsPressed() {}
    }
    // MARK: - Outputs
    struct ErrorOutput {
        var data: BehaviorSubject<ErrorModel>
    }

    private let disposeBag = DisposeBag()
    weak var delegate: ErrorVMDelegate?

    init(_ model: ErrorModel) {
        self.input = ErrorInput()
        self.output = ErrorOutput(data: BehaviorSubject(value: model))
    }

}
