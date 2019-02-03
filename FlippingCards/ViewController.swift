//
//  ViewController.swift
//  FlippingCards
//
//  Created by Alexey Besedin on 03/02/2019.
//  Copyright © 2019 AlexConver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flipsCount = 0 {
        didSet {
            flipsCountTitle.text = "Flips: \(flipsCount)"
        }
    }
    let emojis = ["😛", "😅", "😎", "😡"]
    @IBOutlet var cards: [UIButton]!
    @IBOutlet weak var flipsCountTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if (button.currentTitle != emoji) {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.4295617113, blue: 0, alpha: 1)
        }
        flipsCount += 1
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        flipCard(withEmoji: emojis[cards.index(of: sender)!], on: sender)
    }
}
