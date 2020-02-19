import Foundation

enum Rank: Int, CustomStringConvertible, CaseIterable, Comparable {
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
        case .ace:
            return "Ace"
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
            return  "Queen"
        case .king:
            return "King"
        }
    }
    
    static func <(lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func ==(lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

enum Suit: String, CaseIterable {
    case hearts
    case diamonds
    case spades
    case clubs
}

struct Card: CustomStringConvertible, Comparable {
    let rank: Rank
    let suit: Suit
    
    var description: String {
        return "\(rank.description) of \(suit)"
    }
    
    static func <(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
}

struct Deck {
    let cards: [Card]
    
    init(cards: [Card]? = nil) {
        self.cards = cards ?? Deck.standardCards()
    }
    
    private static func standardCards() -> [Card] {
        var cards = Array<Card>()
        for rank in Rank.allCases {
            for suit in Suit.allCases {
                cards.append(Card(rank: rank, suit: suit))
            }
        }
        return cards
    }
    
    func drawCard() -> Card {
        let index = Int.random(in: 0..<cards.count)
        return cards[index]
    }
}

protocol CardGame: CustomStringConvertible {
    
    var deck: Deck { get }
    
    func play()
}

protocol CardGameDelegate {
    
    func gameDidStart(game: CardGame)
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card)
}

class HighLow: CardGame {
    let deck = Deck()
    var delegate: CardGameDelegate?
    
    let description = "High Low"
    
    func play() {
        delegate?.gameDidStart(game: self)
        delegate?.game(player1DidDraw: deck.drawCard(), player2DidDraw: deck.drawCard())
    }
}

class CardGameTracker: CardGameDelegate {
    
    func gameDidStart(game: CardGame) {
        print("Started a new game of \(game)")
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew a \(card1), player 2 drew a \(card2)")
        if card1 == card2 {
            print("Round ends in a tie")
        } else if card1 > card2 {
            print("Player 1 wins with \(card1)")
        } else {
            print("Player 2 wins with \(card2)")
        }
    }
}

let highLowGame = HighLow()
highLowGame.delegate = CardGameTracker()
highLowGame.play()

