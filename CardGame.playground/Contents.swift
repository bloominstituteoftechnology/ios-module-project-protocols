import UIKit
import Foundation

enum Rank: Int, CustomStringConvertible{
    var description: String {
        switch self.rawValue {
        case 1...10:
            return String(self.rawValue)
        case 11:
            return "jack"
        case 12:
            return "queen"
        case 13:
            return "king"
        default:
            return ""
        }
    }
    
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
        return [ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king]
    }
    
}
extension Rank: Comparable {
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: Rank, rhs: Rank) -> Bool{
        return lhs.rawValue == rhs.rawValue
    }
    
}


enum Suit: String {
    case hearts = "hearts"
    case diamonds = "diamonds"
    case spades = "spades"
    case clubs = "clubs"
    
    static var allSuits: [Suit] {
        return [hearts, diamonds, spades, clubs]
    }
}

struct Card: CustomStringConvertible {
    
    var description: String {
        return "\(rank) of \(suit)"
    }
    
    let rank: Rank
    let suit: Suit
}
extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
    
}

struct Deck {
    let cardsForDeck: [Card]
    
    init() {
        var deck: [Card] = []
        for rank in Rank.allRanks {
            for suit in Suit.allSuits {
                deck.append(Card(rank: rank, suit: suit))
            }
        }
        self.cardsForDeck = deck
    }
    
    func drawCard() -> Card {
        return cardsForDeck.randomElement()!
    }
}
let deck = Deck()
deck.drawCard()

protocol CardGame {
    var deck: Deck {get}
    func play()
}

protocol CardGameDelegate {
    func gameDidStart(_ game: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}

class HighLow: CardGame {
    //CardGame Conformance Protocol Stub
    func play() {
        let player1Card = deck.drawCard()
        let player2Card = deck.drawCard()
        
        print("Player 1 drew \(player1Card)\nPlayer 2 drew \(player2Card)")
        
        if player1Card == player2Card {
            print("Round ends in a tie with \(player1Card)")
        }else if player2Card < player1Card {
            print("Player 1 wins with \(player1Card)")
        }else {
            print("Player 2 wins with \(player2Card)")
        }
        
    }
    
    var deck: Deck = Deck()
    var delegate: CardGameDelegate?
}

class CardGameTracker: CardGameDelegate {
    
    var numberOfTurns: Int = 0
    
    func gameDidStart(_ game: CardGame) {
        numberOfTurns = 0
        if game is HighLow {
            print("Started a game of High Low")
        }
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        numberOfTurns += 1
        print("Player 1 drew \(card1), player 2 drew \(card2)")
    }
}

let tracker = CardGameTracker()
let game = HighLow()
game.delegate = tracker
game.play()
