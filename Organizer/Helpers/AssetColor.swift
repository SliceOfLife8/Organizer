//
//  AssetColor.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 22/2/22.
//

import UIKit

/*
 If you want to use a new color asset, you should add here the name of the color & implement the color into 'Color.xcassets' folder.
 - Be careful: The name of color should be exactly the same both on enum & asset folder because we are using appColor extension static func.
 */

enum AssetsColor: String {
    case primary
    case contentButton
    case almostBlack
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        return UIColor(named: name.rawValue) ?? .black
    }
}
