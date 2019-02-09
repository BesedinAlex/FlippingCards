//
//  Card.swift
//  FlippingCards
//
//  Created by Alexey Besedin on 03/02/2019.
//  Copyright © 2019 AlexConver. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
