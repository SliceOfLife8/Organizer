//
//  Collection+Extensions.swift
//  Organizer
//
//  Created by Petimezas, Chris, Vodafone on 22/2/22.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
