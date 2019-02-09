//
//  ViewController.swift
//  FlippingCards
//
//  Created by Alexey Besedin on 03/02/2019.
//  Copyright © 2019 AlexConver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return cards.count / 2
    }
    @IBOutlet private var cards: [UIButton]!
    @IBOutlet private weak var flipsCountTitle: UILabel!
    private var emojis = ["😛", "😡", "🥶", "🤢", "😈", "🤡", "☠️", "💩"]
    private var emoji = [Int:String]() // Dictionary
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojis.count > 0 {
            emoji[card.identifier] = emojis.remove(at: emojis.count.arc4random)
        }
        return emoji[card.identifier] ?? "?" // ? returns if nil
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        flipsCount += 1
        game.chooseCard(at: cards.index(of: sender)!)
        updateViewFromModel()
    }
    private func updateViewFromModel() {
        for index in cards.indices {
            let button = cards[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.4295617113, blue: 0, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.4295617113, blue: 0, alpha: 1)
            }
        }
    }
    private(set) var flipsCount = 0 {
        didSet {
            flipsCountTitle.text = "Flips: \(flipsCount)"
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
