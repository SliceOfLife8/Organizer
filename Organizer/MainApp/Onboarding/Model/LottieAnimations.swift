//
//  LottieAnimations.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 21/2/22.
//

import Foundation

enum LottieAnim {
    case calendar
    case notifications
    case settings
    case rocket

    var url: String {
        switch self {
        case .calendar:
            return "https://assets2.lottiefiles.com/packages/lf20_ieyjhrgh.json"
        case .notifications:
            return "https://assets2.lottiefiles.com/temp/lf20_7BmGsm.json"
        case .settings:
            return "https://assets8.lottiefiles.com/packages/lf20_cOIcXb.json"
        case .rocket:
            return "https://assets2.lottiefiles.com/packages/lf20_f87yp5ki.json"
        }
    }
}
