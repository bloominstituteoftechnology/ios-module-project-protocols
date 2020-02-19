import Foundation

enum CardsRanks: Int, CustomStringConvertible, Comparable {
    
    
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
    
    var description: String {
        switch self {
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "Jack"
        case .queen:
            return "Queen"
        case .king:
            return "King"
        default:
            return ""
        }
    }
    
    static var allRanks: [CardsRanks] {
        return [.ace,.two,.three,.four,.five,.six,.seven,.eight,.nine,.ten,.jack,.queen,.king]
    }
    static func < (lhs: CardsRanks, rhs: CardsRanks) -> Bool {
            return lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: CardsRanks, rhs: CardsRanks) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum CardsSuit: String {
    case hearts
    case diamonds
    case spades
    case clubs
    
    static var allSuits: [CardsSuit] {
        return [.hearts,.diamonds,.spades,.clubs]
    }

}

struct Card: Comparable, CustomStringConvertible {
    
    
    
    
    let suit: CardsSuit
    let rank: CardsRanks
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.rank == rhs.rank
    }
    var description: String {
        return "\(rank) of \(suit.rawValue)"
    }
}


struct Deck {
    let cards: [Card]
    
    init() {
        var cards: [Card] = []
        for rank in CardsRanks.allRanks {
            for suit in CardsSuit.allSuits {
                let card: Card = Card(suit: suit, rank: rank)
                cards.append(card)
            }
        }
        self.cards = cards
    }
    
    func drawCard() -> Card {
        let random = Int.random(in: 0...self.cards.count)
        return cards[random]
    }
}


protocol CardGame {
    var deck: Deck { get }
    func play()
}

protocol CardGameDelegate {
    func gameDidStart(_ game: CardGame)
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}



class HighLow: CardGame {
    var deck: Deck
    var delegate: CardGameDelegate?
    
    func play() {
        guard let delegate = delegate else { return }
        
        let card1 = deck.drawCard()
        let card2 = deck.drawCard()
        
        delegate.gameDidStart(self)
        delegate.game(player1DidDraw: card1, player2DidDraw: card2)
        
        if card1 == card2 {
            print("Round ends in a tie with \(card1)")
        } else if card1.rank == card2.rank && card1.suit != card2.suit{
            switch card1.suit {
            case .clubs:
                print("Player 2 wins with \(card2) against \(card1)")
            case .diamonds:
                if card2.suit == .clubs {
                    print("Player 1 wins with \(card1) against \(card2)")
                } else {
                    print("Player 2 wins with \(card2) against \(card1)")
                }
            case .hearts:
                if card2.suit == .spades {
                    print("Player 2 wins with \(card2) against \(card1)")
                } else {
                    print("Player 1 wins with \(card1) against \(card2)")
                }
            case .spades:
                print("Player 1 wins with \(card1) against \(card2)")
            }
        }else if card1 > card2 {
            print("Player 1 wins with \(card1) against \(card2)")
        } else {
            print("Player 2 wins with \(card2) against \(card1)")
        }
        
        
    }
    
    init (deck: Deck) {
        self.deck = deck
    }
}

class CardGameTracker: CardGameDelegate {
    var numberOfTurns: Int = 0
    func gameDidStart(_ game: CardGame) {
        numberOfTurns = 0
        if game is HighLow {
            print("Started a new game of High Low!")
        }
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew a \(card1) and Player 2 drew a \(card2)")
    }
    
    init () {
        
    }
    
}

let newDeck = Deck()
let highLow: HighLow = HighLow(deck: newDeck)

let highLowDelegator: CardGameTracker = CardGameTracker()
highLow.delegate = highLowDelegator

highLow.play()


