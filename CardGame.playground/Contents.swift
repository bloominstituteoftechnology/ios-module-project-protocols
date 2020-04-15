import Foundation

enum Rank: Int, Comparable {
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    static func == (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue == rhs.rawValue
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
        return [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, . jack, .queen, .king]
    }
}


extension Rank: CustomStringConvertible {
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
            return "Queen"
        case .king:
            return "King"
        }
    }
}

enum Suit: String {
    case hearts = "Hearts"
    case diamonds = "Diamonds"
    case spades = "Spades"
    case clubs = "Clubs"
    
    static var allSuits: [Suit] {
        return [.hearts, .diamonds, .spades, .clubs]
    }
}

struct Card: CustomStringConvertible, Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank > rhs.rank
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
          return lhs.rank == rhs.rank
    }
    let rank: Rank.RawValue
    let suit: Suit.RawValue
    var description: String {
        return ("\(rank) of \(suit)")
    }
}

struct Deck {
    let deckOfCards: [Card]
    
    init() {
        var deckOfCards: [Card] = []
        for currentRank in Rank.allRanks {
            for currentSuit in Suit.allSuits {
                let newCard: Card = Card(rank: Rank(rawValue: currentRank.rawValue)!.rawValue, suit: Suit(rawValue: currentSuit.rawValue)!.rawValue)
                deckOfCards.append(newCard)
            }
        }
        self.deckOfCards = deckOfCards
    }
    
    func drawCard() -> Card {
        let randomNum = Int.random(in: 0...deckOfCards.count-1)
        return deckOfCards[randomNum]
    }
}


let newDeck: Deck = Deck()




protocol CardGame {
    var deck: Deck { get }
    func play()
}


protocol CardGameDelegate {
    func gameDidStart()
    func game(player1DidDraw card1 : Card, player2DidDraw card2: Card)
}

class HighLow: CardGame {
    var deck: Deck = Deck()
    var cardGameDelegate: CardGameDelegate?
    
    func play() {
        cardGameDelegate?.gameDidStart()
        let player1Card = deck.drawCard()
        let player2Card = deck.drawCard()
        
        cardGameDelegate?.game(player1DidDraw: player1Card, player2DidDraw: player2Card)
        if player1Card.rank == player2Card.rank {
            print("Round ends in a tie with a \(player2Card.description)!")
        } else if player1Card.rank > player2Card.rank {
            print("Player 1 wins with a \(player1Card.description)")
        } else if player1Card.rank < player2Card.rank {
            print("Player 2 wins with a \(player2Card.description)")
        } else {
            print("...this isnt where I left my car")
        }
    }
}

class CardGameTracker: CardGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart() {
        print("Started a new game of High Low!")
    }
    
    func game(player1DidDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 drew a \(card1.description) and Player 2 drew a \(card2.description)")
    }
}

let newGame = HighLow()
let newTracker = CardGameTracker()
newGame.cardGameDelegate = newTracker
newGame.play()

