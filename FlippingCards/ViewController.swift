//
//  ViewController.swift
//  FlippingCards
//
//  Created by Alexey Besedin on 03/02/2019.
//  Copyright © 2019 AlexConver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var emojis = ["😛", "😡", "🥶", "🤢", "😈", "🤡", "☠️", "💩"]
    var emoji = [Int:String]() // Dictionary
    @IBOutlet var cards: [UIButton]!
    lazy var game = Concentration(numberOfPairsOfCards: cards.count / 2)
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emoji[card.identifier] = emojis.remove(at: randomIndex )
        }
        return emoji[card.identifier] ?? "?" // ? returns if nil
    }
    func updateViewFromModel() {
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
    @IBAction func touchCard(_ sender: UIButton) {
        game.chooseCard(at: cards.index(of: sender)!)
        updateViewFromModel()
    }
    @IBAction func startAllOver(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: cards.count / 2)
        emoji.removeAll()
        emojis = ["😛", "😡", "🥶", "🤢", "😈", "🤡", "☠️", "💩"]
        updateViewFromModel()
    }
}
