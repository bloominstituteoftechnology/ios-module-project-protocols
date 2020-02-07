import UIKit

enum Rank: Int {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    static var allRanks: [Rank] {
        return [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
    }
}

// Make Rank conform to the CustomStringConvertible Protocol

extension Rank: CustomStringConvertible, Comparable {
    var description: String {
        switch(self) {
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return "\(self.rawValue)"
        }
    }
    static func == (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

enum Suit: String {
    case hearts
    case diamonds
    case spades
    case clubs
    static var allSuits: [Suit] {
        return [.hearts, .diamonds, .spades, .clubs]
    }
}

struct Card {
    let rank: Rank
    let suit: Suit
}

extension Card: CustomStringConvertible, Comparable {
    var description: String {
        return "\(self.rank) of \(self.suit)"
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank.rawValue < rhs.rank.rawValue
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.suit.rawValue == rhs.suit.rawValue && lhs.rank.rawValue == rhs.rank.rawValue
    }
}

// Iterate over ranks, then suits - nested loops
struct Deck {
    let Cards: [Card]
    init() {
        var array: [Card] = []
        for rank in Rank.allRanks {
            for suit in Suit.allSuits {
                array.append(Card(rank: rank, suit: suit))
            }
        }
        self.Cards = array
    }
    
    func drawCard() -> Card {
        return Cards[Int.random(in: 0...51)]
    }
}

protocol CardGame {
    var deck: Deck { get}
    func play()
}

class HighLow: CardGame {
    var deck = Deck()
    func play() {
        let p1Card = deck.drawCard()
        let p2Card = deck.drawCard()
        
        if p1Card < p2Card {
            print("Player 2 wins, they drew \(p2Card)")
        } else if p1Card == p2Card {
            print("Tie! Both players drew \(p1Card)")
        } else {
            print("Player 1 wins, they drew \(p1Card)")
        }
    }
}

var myGame = HighLow()
for _ in 0...10 {
    myGame.play()
}
