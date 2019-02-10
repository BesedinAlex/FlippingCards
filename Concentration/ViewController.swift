import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return cards.count / 2
    }
    private(set) var flipsCount = 0 {
        didSet {
            updateFlipCountTitle()
        }
    }
    @IBOutlet private var cards: [UIButton]!
    @IBOutlet private weak var flipsCountTitle: UILabel! {
        didSet {
            updateFlipCountTitle()
        }
    }
    private var emojis = "😛😡🥶🤢😈🤡☠️💩🎃🤖"
    private var emoji = [Card:String]() // Dictionary
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojis.count > 0 {
            let randomStringIndex = emojis.index(emojis.startIndex, offsetBy: emojis.count.arc4random)
            emoji[card] = String(emojis.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?" // ? returns if nil
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
    private func updateFlipCountTitle() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.9372549057, green: 0.4295617113, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipsCount)", attributes: attributes)
        flipsCountTitle.attributedText = attributedString
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
