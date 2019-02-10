import Foundation

struct Card: Hashable {
    var hashValue: Int {
        return identifier
    }
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
