import Foundation

// Step 1 -
enum Rank: Int,CustomStringConvertible {

    case ace = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13

// Step 2 -
    var description: String {
        switch self {
        case .ace:
            return "ace"
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
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "King"


        }
    }
    //Step 7 -
    static var allRanks: [Rank] = [.ace,.two,.three,.four,.five,.six,.seven,.eight,.nine,.ten,.jack,.queen,.king]
}

//Step 3 -
enum Suits {
    case hearts, diamonds, spades, clubs

    static var allSuits: [Suits] {
        return [.hearts, .diamonds, .spades, .clubs]
    }
}



//Step 4 -
struct Card: CustomStringConvertible, Comparable {
 // Step 18
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank != rhs.rank {
            return lhs.rank.rawValue < rhs.rank.rawValue
        } else {
            return false
        }
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.rank == rhs.rank &&
            lhs.suit == rhs.suit {
            return true
        } else {
            return false
        }
    }
    
    let suit: Suits
    let rank: Rank
    // Step 5
    var description: String {
        return "\(rank) of \(suit)"
    }
}
  
//Step 6 -
struct Deck {
    let cards: [Card]
    
    //Step 9 -
    init() {
        var stack: [Card] = []
                for suit in Suits.allSuits {
                for rank in Rank.allRanks {
                    stack.append(Card(suit: suit,rank: rank))
                    }
                }
                self.cards = stack
            }
    // Step 11-
            func drawCards() -> Card {
                let randomNumber = Int.random(in: 1...cards.count) - 1
                return cards[randomNumber]
            }

        }

//Step 12-
protocol CardGame {
    var deck: Deck { get }
    func play()
    
    }

//Step 13-
protocol CardGameDelegate {
    
   func gameDidStart(_ CardGame:CardGame)
    func game(player1didDraw card1: Card, player2DidDraw card2: Card)
    
}



//Step 14-
class HighLow: CardGame {
    var deck: Deck = Deck()
    var cardGameDelegate: CardGameDelegate?

//Step 19
    func play() {

        let player1Card = deck.drawCards()
        let player2Card = deck.drawCards()
        
        cardGameDelegate?.gameDidStart(self)
        
        cardGameDelegate?.game(player1didDraw: player1Card, player2DidDraw: player2Card)

        if player1Card == player2Card {
            print("Round ends in a tie with the \(player1Card.description)")
        } else if player1Card > player2Card {
            print("Player 1 wins with the \(player1Card.description)")
        } else {
            print("Player 2 wins with the \(player2Card.description)")
        }

    }

}

//Step 15
    class CardGameTracker:CardGameDelegate {
    func gameDidStart(_ cardGame: CardGame) {
        if cardGame is HighLow {
            print("Started a new game of High Low!")
        }
    }

    func game(player1didDraw card1: Card, player2DidDraw card2: Card) {
        print("Player 1 draws a card:\(card1), player 2 also draws a card: \(card2)")
    }


}

//  Step 21
let newGame = HighLow()
let tracker = CardGameTracker()

newGame.play()
